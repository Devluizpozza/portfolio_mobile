import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:portfolio_app/app/components/pdf_viwer_ui.dart';
import 'package:portfolio_app/app/modules/github/github_bindings.dart';
import 'package:portfolio_app/app/modules/github/github_view.dart';
import 'package:portfolio_app/app/modules/home/home_view.dart';
import 'package:portfolio_app/app/modules/projects/projects_bindings.dart';
import 'package:portfolio_app/app/modules/projects/projects_view.dart';
import 'package:portfolio_app/app/routes/app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.INITIAL, page: () => Home()),
    GetPage(name: AppRoutes.CURRICULO, page: () => PdfViewer()),
    GetPage(
      name: AppRoutes.PROJETOS,
      page: () => ProjectsView(),
      binding: ProjectsBinding(),
    ),
    GetPage(
      name: AppRoutes.GITHUB,
      page: () => GitHubView(),
      binding: GitHubBinding(),
    ),
    GetPage(name: AppRoutes.ORCAMENTOS, page: () => Text('')),
  ];
}
