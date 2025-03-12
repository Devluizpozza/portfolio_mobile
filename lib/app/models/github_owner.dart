import 'package:equatable/equatable.dart';

class GitHubOwner extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  const GitHubOwner({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory GitHubOwner.fromJson(Map<String, dynamic> json) {
    return GitHubOwner(
      id: json['id'] ?? 0,
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }

  @override
  List<Object?> get props => [id, login, avatarUrl, htmlUrl];
}
