import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  // Construtor nomeado para um objeto vazio (ex: inicializações)
  factory Project.empty() {
    return Project(
      id: '',
      name: '',
      description: '',
      createdAt: DateTime.now(),
    );
  }

  // Construtor para criar um objeto a partir de um JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  // Método para converter um objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Método para criar uma cópia do objeto com novas propriedades
  Project copyWith({
    String? id,
    String? name,
    String? description,
    double? budget,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Equatable para facilitar comparações entre objetos
  @override
  List<Object> get props => [id, name, description, createdAt];

  get title => null;
}
