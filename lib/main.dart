import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio_app/app/app_widget.dart';
import 'package:portfolio_app/app/modules/projects/projects_controller.dart';

void main() {
  Get.lazyPut(() => ProjectsController());
  runApp(AppWidget());
}
