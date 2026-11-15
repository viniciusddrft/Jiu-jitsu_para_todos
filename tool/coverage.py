
#!/usr/bin/env python3
"""Executa toda a suíte e exige 80% das linhas do código Dart do app."""
import argparse
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def generated(path):
    """Apenas JNIgen, Flutter gen-l10n e configuração FlutterFire."""
    return (path.endswith('.g.dart') or path == 'lib/firebase_options.dart'
            or path in {f'lib/src/shared/l10n/app_localizations{suffix}.dart'
                        for suffix in ('', '_en', '_pt')})


def prepare():
    files = sorted(p.relative_to(ROOT).as_posix() for p in (ROOT / 'lib').rglob('*.dart')
                   if not generated(p.relative_to(ROOT).as_posix()))
    imports = ''.join(f"import 'package:jiu_jitsu_para_todos/{p[4:]}';\n" for p in files)
    (ROOT / 'test/coverage_test.dart').write_text(
        '// Mantém arquivos ainda sem testes no denominador da cobertura.\n'
        '// Atualizado por tool/coverage.py.\n// ignore_for_file: unused_import\n'
        + imports + "import 'package:flutter_test/flutter_test.dart';\n\n"
        "void main() {\n"
        "  test('carrega todas as bibliotecas do app para medir cobertura', () {});\n}\n")


def report(path, minimum):
    records = {}
    for block in path.read_text().split('end_of_record'):
        source = None
        for line in block.strip().splitlines():
            if line.startswith('SF:'):
                source = line[3:]
                if Path(source).is_absolute():
                    source = Path(source).relative_to(ROOT).as_posix()
                if generated(source) or not source.startswith('lib/'):
                    source = None
                else:
                    records.setdefault(source, {})
            elif line.startswith('DA:') and source:
                number, count, *_ = line[3:].split(',')
                lines = records[source]
                lines[int(number)] = lines.get(int(number), 0) + int(count)
    total = covered = 0
    output = []
    for source, lines in sorted(records.items()):
        hit = sum(count > 0 for count in lines.values())
        total += len(lines)
        covered += hit
        output.append(f'{hit:4}/{len(lines):4}  {100 * hit / len(lines) if lines else 100:6.2f}%  {source}')
    if not total:
        raise ValueError('Relatório sem linhas de código do app.')
    percentage = 100 * covered / total
    summary = f'Cobertura: {covered}/{total} linhas ({percentage:.2f}%). Mínimo: {minimum:g}%.'
    print('\n'.join(output + [summary]))
    (ROOT / 'coverage/summary.txt').write_text('\n'.join(output + [summary]) + '\n')
    filtered = []
    for source, lines in sorted(records.items()):
        filtered.extend([f'SF:{source}', *(f'DA:{n},{c}' for n, c in sorted(lines.items())),
                         f'LF:{len(lines)}', f'LH:{sum(c > 0 for c in lines.values())}', 'end_of_record'])
    (ROOT / 'coverage/app.info').write_text('\n'.join(filtered) + '\n')
    return 0 if covered * 100 >= total * minimum else 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check-only', action='store_true', help='Verifica coverage/lcov.info existente.')
    parser.add_argument('--minimum', type=float, default=80)
    args = parser.parse_args()
    if not 0 <= args.minimum <= 100:
        parser.error('--minimum deve estar entre 0 e 100')
    if not args.check_only:
        prepare()
        result = subprocess.run(['flutter', 'test', '--coverage'], cwd=ROOT)
        if result.returncode:
            return result.returncode
    try:
        return report(ROOT / 'coverage/lcov.info', args.minimum)
    except (OSError, ValueError) as error:
        print(f'Não foi possível validar cobertura: {error}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
