import 'package:get/get.dart';
import 'package:portfolio_app/app/modules/projects/projects_controller.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(() => ProjectsController());
  }
}
