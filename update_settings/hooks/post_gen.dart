import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  // Accept the base project path as input
  final projectPath = context.vars['project_path'] as String;

  // Paths to the files to be created or updated
  final settingsFile = File(
      '/Users/yudizsolutionsltd/Library/Application Support/Cursor/User/settings.json');
  final masonFile = File('$projectPath/mason.yaml');
  final bricksJsonFile = File('$projectPath/.mason/bricks.json');

  // Function to ensure directory exists
  void ensureDirectory(String path) {
    final directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }

  // Step 1: Update settings.json
  if (settingsFile.existsSync()) {
    try {
      final content = settingsFile.readAsStringSync();
      final json = jsonDecode(content);

      if (!json.containsKey('dart.analysisExcludedFolders')) {
        json['dart.analysisExcludedFolders'] = [];
      }

      final exclusions =
          List<String>.from(json['dart.analysisExcludedFolders']);
      if (!exclusions.contains('bricks-repository')) {
        exclusions.add('bricks-repository');
        json['dart.analysisExcludedFolders'] = exclusions;

        final updatedContent = JsonEncoder.withIndent('  ').convert(json);
        settingsFile.writeAsStringSync(updatedContent);
        context.logger.info(
            'Updated settings.json and added "bricks-repository" to exclusions.');
      } else {
        context.logger.info(
            '"bricks-repository" is already present in dart.analysisExcludedFolders.');
      }
    } catch (e) {
      context.logger.err('Error updating settings.json: $e');
    }
  } else {
    context.logger.err('settings.json file does not exist.');
  }

  // Step 2: Create or update mason.yaml
  final masonContent = '''
# Register bricks which can be consumed via the Mason CLI.
# Run "mason get" to install all registered bricks.
# To learn more, visit https://docs.brickhub.dev.
bricks:
  feature:
    path: bricks-repository/feature
  add_string:
    path: bricks-repository/add_string
  update_settings:
    path: bricks-repository/update_settings
''';

  try {
    masonFile.writeAsStringSync(masonContent);
    context.logger.info('Created or updated mason.yaml at project level.');
  } catch (e) {
    context.logger.err('Error creating mason.yaml: $e');
  }

  // Step 3: Create or update .mason/bricks.json
  ensureDirectory('$projectPath/.mason');
  final bricksJsonContent = {
    "add_string": "$projectPath/bricks-repository/add_string",
    "feature": "$projectPath/bricks-repository/feature",
    "update_settings": "$projectPath/bricks-repository/update_settings"
  };

  try {
    bricksJsonFile.writeAsStringSync(
        JsonEncoder.withIndent('  ').convert(bricksJsonContent));
    context.logger
        .info('Created or updated .mason/bricks.json with brick paths.');
  } catch (e) {
    context.logger.err('Error creating .mason/bricks.json: $e');
  }
}
