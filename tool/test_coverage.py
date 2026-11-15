"""Testes da barreira de cobertura: python3 -m unittest discover -s tool."""
import contextlib
import importlib.util
import io
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('coverage_gate', Path(__file__).with_name('coverage.py'))
coverage = importlib.util.module_from_spec(spec)
spec.loader.exec_module(coverage)


class CoverageGateTest(unittest.TestCase):
    def check(self, report):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'coverage').mkdir()
            path = root / 'coverage/lcov.info'
            path.write_text(report)
            with patch.object(coverage, 'ROOT', root), contextlib.redirect_stdout(io.StringIO()):
                code = coverage.report(path, 80)
            return code, (root / 'coverage/app.info').read_text()

    def test_accepts_exactly_eighty_percent(self):
        code, _ = self.check('SF:lib/example.dart\nDA:1,1\nDA:2,1\nDA:3,1\nDA:4,1\nDA:5,0\nend_of_record\n')
        self.assertEqual(code, 0)

    def test_rejects_below_threshold(self):
        code, _ = self.check('SF:lib/example.dart\nDA:1,1\nDA:2,0\nend_of_record\n')
        self.assertEqual(code, 1)

    def test_generated_files_are_excluded_but_native_wrappers_are_counted(self):
        report = ''.join(f'SF:{path}\nDA:1,{hit}\nend_of_record\n' for path, hit in [
            ('lib/example.dart', 1),
            ('lib/example.g.dart', 0),
            ('lib/firebase_options.dart', 0),
            ('lib/src/shared/l10n/app_localizations_pt.dart', 0),
            ('lib/src/shared/plugins/wallpaper/wallpaper_setter.dart', 0),
        ])
        code, filtered = self.check(report)
        self.assertEqual(code, 1)
        self.assertNotIn('example.g.dart', filtered)
        self.assertNotIn('firebase_options.dart', filtered)
        self.assertNotIn('app_localizations_pt.dart', filtered)
        self.assertIn('wallpaper_setter.dart', filtered)

    def test_merges_duplicate_records_without_inflating_denominator(self):
        code, filtered = self.check('SF:lib/a.dart\nDA:1,0\nend_of_record\nSF:lib/a.dart\nDA:1,1\nend_of_record\n')
        self.assertEqual(code, 0)
        self.assertEqual(filtered.count('DA:1,'), 1)

    def test_empty_report_fails_closed(self):
        with self.assertRaises(ValueError):
            self.check('')

    def test_prepare_includes_uncovered_files(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'lib').mkdir()
            (root / 'test').mkdir()
            (root / 'lib/untested.dart').write_text('int answer() => 42;')
            (root / 'lib/generated.g.dart').write_text('// generated')
            with patch.object(coverage, 'ROOT', root):
                coverage.prepare()
            imports = (root / 'test/coverage_test.dart').read_text()
            self.assertIn('untested.dart', imports)
            self.assertNotIn('generated.g.dart', imports)


if __name__ == '__main__':
    unittest.main()
