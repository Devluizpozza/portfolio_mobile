import 'package:equatable/equatable.dart';

class GitHubUser extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;

  const GitHubUser({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      id: json['id'] ?? 0,
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      bio: json['bio'] ?? 'Sem biografia',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'bio': bio,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
    };
  }

  @override
  List<Object?> get props => [
    id,
    login,
    avatarUrl,
    htmlUrl,
    bio,
    publicRepos,
    followers,
    following,
  ];
}
