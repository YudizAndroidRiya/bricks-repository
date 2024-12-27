import 'dart:io';
import 'package:mason/mason.dart' hide camelCase;
import 'package:recase/recase.dart';

void run(HookContext context) {
  final keyValue = context.vars['keyValue'] as String;
  final parts = keyValue.split(':');
  if (parts.length != 2) {
    context.logger.err('Invalid format. Please use "key:value".');
    return;
  }
  final key = parts[0].trim();
  final value = parts[1].trim();

  // File paths
  final enUsFile =
      File('lib/resources/localization/en_us/en_us_translations.dart');
  final appStringFile = File('lib/resources/localization/app_string.dart');

  // Update en_us_translations.dart
  if (enUsFile.existsSync()) {
    final enUsContent = enUsFile.readAsStringSync();
    if (!enUsContent.contains('"$key":')) {
      final updatedEnUsContent = enUsContent.replaceFirstMapped(
        RegExp(r'(final Map<String, String> enUs = {[\s\S]*?)\};',
            multiLine: true),
        (match) => '${match.group(1)}  "$key": "$value",\n};',
      );
      enUsFile.writeAsStringSync(updatedEnUsContent);
      context.logger.info('Added "$key": "$value" to en_us_translations.dart');
    } else {
      context.logger
          .info('Key "$key" already exists in en_us_translations.dart');
    }
  } else {
    context.logger.err('en_us_translations.dart file does not exist');
  }

  // Update app_string.dart
  if (appStringFile.existsSync()) {
    final appStringContent = appStringFile.readAsStringSync();
    final variableName = ReCase(key).camelCase;
    if (!appStringContent.contains('static var $variableName =')) {
      final updatedAppStringContent = appStringContent.replaceFirstMapped(
        RegExp(r'class AppStrings \{([\s\S]*?)\}', multiLine: true),
        (match) =>
            'class AppStrings {\n  static var $variableName = \'$key\'.tr;\n${match.group(1)}}',
      );
      appStringFile.writeAsStringSync(updatedAppStringContent);
      context.logger
          .info('Added static variable for key "$key" in app_string.dart');
    } else {
      context.logger.info(
          'Static variable for key "$key" already exists in app_string.dart');
    }
  } else {
    context.logger.err('app_string.dart file does not exist');
  }
}
