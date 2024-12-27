import 'package:{{project_name}}/core/app_exports.dart';
import '../controller/{{name.snakeCase()}}_controller.dart';
class {{name.pascalCase()}}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => {{name.pascalCase()}}Controller());
  }
}
