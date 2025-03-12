import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:portfolio_app/app/models/github_owner.dart';
import 'package:portfolio_app/app/models/github_repo.dart';
import 'package:portfolio_app/app/models/github_user.dart';
import 'package:portfolio_app/app/models/project.dart';
import 'package:portfolio_app/app/services/github_service.dart';

class ProjectsController extends GetxController {
  final Rx<List<Project?>> _projects = Rx<List<Project?>>([]);
  final GitHubService gitHubService = GitHubService();
  final Rx<GitHubOwner?> _gitHubOwner = Rx<GitHubOwner?>(null);
  final Rx<List<GitHubRepo>> _userRepos = Rx<List<GitHubRepo>>([]);
  final Rx<GitHubUser?> _gitHubUser = Rx<GitHubUser?>(null);
  final Rx<bool> _isLoading = false.obs;

  List<Project?> get projects => _projects.value;

  set projects(List<Project?> value) {
    _projects.value = value;
    _projects.refresh();
  }

  List<GitHubRepo> get userRepos => _userRepos.value;

  set userRepos(List<GitHubRepo> value) {
    _userRepos.value = value;
    _userRepos.refresh();
  }

  GitHubOwner? get gitHubOwner => _gitHubOwner.value;

  set gitHubOwner(GitHubOwner? value) {
    _gitHubOwner.value = value;
    _gitHubOwner.refresh();
  }

  GitHubUser? get gitHubUser => _gitHubUser.value;

  set gitHubUser(GitHubUser? value) {
    _gitHubUser.value = value;
    _gitHubUser.refresh();
  }

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  @override
  void onInit() async {
    populateProjects();
    super.onInit();
  }

  void fetchGitHubRepos(String username) async {
    isLoading = true;
    try {
      userRepos = await gitHubService.fetchUserRepos(username);
    } catch (e) {
      print(e.toString);
    } finally {
      isLoading = false;
    }
  }

  void populateProjects() {
    if (projects.isEmpty) {
      for (int i = 0; i < 6; i++) {
        Project newProject = Project(
          name: "project $i",
          id: "$i",
          description: "Descrição $i",
          createdAt: DateTime.now(),
        );
        projects.add(newProject);
      }
    }
  }

  Future<void> fetchUserData(String username) async {
    try {
      isLoading = true;

      gitHubUser = await gitHubService.fetchUserProfile(username);
      userRepos = await gitHubService.fetchUserRepos(username);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
