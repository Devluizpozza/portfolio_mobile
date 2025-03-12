import 'package:get/get.dart';
import 'package:portfolio_app/app/modules/github/github_controller.dart';

class GitHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GitHubController>(() => GitHubController());
  }
}
