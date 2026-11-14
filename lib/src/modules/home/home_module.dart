import 'package:flutter_modular/flutter_modular.dart';
import 'ui/home_page.dart';

final homeModule = createModule(
  path: '/',
  register: (c) => c.route('/', child: (context, state) => const HomePage()),
);
