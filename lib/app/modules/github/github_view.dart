import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:portfolio_app/app/components/title_subtitle_ui.dart';
import 'package:portfolio_app/app/modules/github/github_controller.dart';

class GitHubView extends GetView<GitHubController> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  GitHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoading,
        replacement: Center(child: CircularProgressIndicator()),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 26),
                onPressed: () {
                  controller.searchUser = '';
                  controller.userRepos = [];
                  Get.back();
                },
              ),
              actionsPadding: EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: Colors.amber,
              title: Center(child: Text('GitHub API')),
              elevation: 2,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    TextEditingController textController =
                        TextEditingController();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 16,
                            top: 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: "Pesquisar",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {
                                      controller.searchUser =
                                          textController.text;
                                      controller.fetchUserData(null);

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(
                                () =>
                                    Text("Pesquisa: ${controller.searchUser}"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                CircleAvatar(
                  maxRadius: 70,
                  minRadius: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, style: BorderStyle.none),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        controller.gitHubUser?.avatarUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  controller.gitHubUser?.login ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Text(
                  controller.gitHubUser?.htmlUrl ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "Repos",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  items:
                      controller.userRepos.map((e) {
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
                                    title: e.name,
                                    subtitle: e.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
        ),
      ),
    );
  }
}
