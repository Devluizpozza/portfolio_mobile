import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portfolio_app/app/models/github_repo.dart';
import 'package:portfolio_app/app/models/github_user.dart';

class GitHubService {
  static const String baseUrl = "https://api.github.com";

  Future<List<GitHubRepo>> fetchUserRepos(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$username/repos'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((repo) => GitHubRepo.fromJson(repo)).toList();
      } else {
        throw Exception("Erro ao buscar repositórios: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Falha na requisição dos repositórios: $e");
    }
  }

  Future<GitHubUser> fetchUserProfile(String username) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$username'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return GitHubUser.fromJson(jsonData);
      } else {
        throw Exception("Erro ao buscar perfil: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Falha na requisição do perfil do usuário: $e");
    }
  }
}
