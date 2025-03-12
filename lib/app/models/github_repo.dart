import 'package:equatable/equatable.dart';
import 'package:portfolio_app/app/models/github_owner.dart';

class GitHubRepo extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String description;
  final String language;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final GitHubOwner owner;

  const GitHubRepo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.owner,
  });

  factory GitHubRepo.fromJson(Map<String, dynamic> json) {
    return GitHubRepo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      description: json['description'] ?? 'Sem descrição',
      language: json['language'] ?? 'Desconhecido',
      stargazersCount: json['stargazers_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      owner: GitHubOwner.fromJson(json['owner'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'html_url': htmlUrl,
      'description': description,
      'language': language,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'forks_count': forksCount,
      'owner': owner.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    fullName,
    htmlUrl,
    description,
    language,
    stargazersCount,
    watchersCount,
    forksCount,
    owner,
  ];
}
