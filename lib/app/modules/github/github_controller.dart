import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:portfolio_app/app/database/database_helper.dart';
import 'package:portfolio_app/app/models/github_owner.dart';
import 'package:portfolio_app/app/models/github_repo.dart';
import 'package:portfolio_app/app/models/github_user.dart';
import 'package:portfolio_app/app/models/project.dart';
import 'package:portfolio_app/app/services/github_service.dart';

class GitHubController extends GetxController {
  final Rx<List<Project?>> _projects = Rx<List<Project?>>([]);
  final GitHubService gitHubService = GitHubService();
  final Rx<GitHubOwner?> _gitHubOwner = Rx<GitHubOwner?>(null);
  final Rx<List<GitHubRepo>> _userRepos = Rx<List<GitHubRepo>>([]);
  final Rx<GitHubUser?> _gitHubUser = Rx<GitHubUser?>(null);
  final Rx<String> _searchUser = Rx<String>('');
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

  String get searchUser => _searchUser.value;

  set searchUser(String value) {
    _searchUser.value = value;
    _searchUser.refresh();
  }

  @override
  void onInit() async {
    isLoading = true;
    await fetchUserData('leagueliine');
    isLoading = false;

    super.onInit();
  }

  Future<void> fetchUserData(String? username) async {
    try {
      if (username != null) {
        gitHubUser = await gitHubService.fetchUserProfile(username);
        userRepos = await gitHubService.fetchUserRepos(username);
      }
      gitHubUser = await gitHubService.fetchUserProfile(searchUser);
      userRepos = await gitHubService.fetchUserRepos(searchUser);
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  Future<void> loadLocalData() async {
    try {
      gitHubUser =
          (await DBHelper.instance.getGitHubUsers()).isNotEmpty
              ? (await DBHelper.instance.getGitHubUsers()).first
              : null;
      userRepos = await DBHelper.instance.getGitHubRepos();
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> saveLocalData() async {
    try {
      await DBHelper.instance.insertGitHubUser(gitHubUser!);
      await DBHelper.instance.insertGitHubRepos(userRepos);
    } catch (e) {
      throw Exception("$e");
    }
  }
}
