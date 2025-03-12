import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:portfolio_app/app/components/title_subtitle_ui.dart';
import 'package:portfolio_app/app/modules/projects/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Projetos'),
          elevation: 2,
          titleSpacing: 100,
        ),
        body: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width - 20,
                maxHeight: 250,
              ),
              child: CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
                items:
                    controller.projects.map((e) {
                      return SizedBox(
                        width: 300,
                        child: Card(
                          elevation: 4,
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleSubtitle(
                                  title: e?.name ?? "",
                                  subtitle: e?.description ?? "",
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
                  onPressed: () => carouselController.previousPage(),
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.arrow_circle_right_outlined, size: 30),
                  onPressed: () => carouselController.nextPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
