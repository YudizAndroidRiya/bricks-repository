import 'dart:io';
import 'package:mason/mason.dart' hide camelCase;
import 'package:recase/recase.dart';

void run(HookContext context) {
  final name = context.vars['name'] as String;
  final pascalName = ReCase(name).pascalCase;
  final snakeName = ReCase(name).snakeCase;

  final appRoutesFile = File('lib/core/navigation/routes/app_routes.dart');

  if (appRoutesFile.existsSync()) {
    final appRoutesContent = appRoutesFile.readAsStringSync();

    // Add import statements if they don't already exist
    final importScreen =
        "import 'package:ruos_utility/presentation/${snakeName}/widget/${snakeName}_screen.dart';";
    final importBinding =
        "import 'package:ruos_utility/presentation/${snakeName}/binding/${snakeName}_binding.dart';";

    String updatedAppRoutesContent = appRoutesContent;

    if (!appRoutesContent.contains(importScreen)) {
      updatedAppRoutesContent = "$importScreen\n$updatedAppRoutesContent";
    }

    if (!appRoutesContent.contains(importBinding)) {
      updatedAppRoutesContent = "$importBinding\n$updatedAppRoutesContent";
    }

    // Check if the route already exists
    if (!appRoutesContent.contains(
        "static const String ${snakeName}Screen = '/${snakeName}Screen';")) {
      // Add the new route constant
      updatedAppRoutesContent = updatedAppRoutesContent.replaceFirst(
        'static const String dashboardScreen = \'/dashboardScreen\';',
        'static const String dashboardScreen = \'/dashboardScreen\';\n  static const String ${snakeName}Screen = \'/${snakeName}Screen\';',
      );

      // Add the new GetPage entry
      updatedAppRoutesContent = updatedAppRoutesContent.replaceFirst(
        '// GetPage(',
        'GetPage(\n'
            '      name: ${snakeName}Screen,\n'
            '      transition: Transition.fadeIn,\n'
            '      page: () => ${pascalName}Screen(),\n'
            '      bindings: [${pascalName}Binding()],\n'
            '    ),\n'
            '    // GetPage(',
      );

      appRoutesFile.writeAsStringSync(updatedAppRoutesContent);
      context.logger.info('Added ${pascalName}Screen to app_routes.dart');
    } else {
      context.logger
          .info('${pascalName}Screen already exists in app_routes.dart');
    }
  } else {
    context.logger.err('app_routes.dart file does not exist');
  }
}
