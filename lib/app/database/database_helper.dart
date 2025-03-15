import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/github_user.dart';
import '../models/github_repo.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('github.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, fileName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE github_repos ADD COLUMN owner TEXT');
        }
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE github_users (
        id INTEGER PRIMARY KEY,
        login TEXT,
        avatar_url TEXT,
        html_url TEXT,
        bio TEXT,
        public_repos INTEGER,
        followers INTEGER,
        following INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE github_repos (
       id INTEGER PRIMARY KEY,
       name TEXT,
       full_name TEXT,
       html_url TEXT,
       description TEXT,
       language TEXT,
       stargazers_count INTEGER,
       watchers_count INTEGER,
       forks_count INTEGER,
       owner TEXT
     )
    ''');
  }

  Future<int> insertGitHubUser(GitHubUser user) async {
    final db = await instance.database;
    return await db.insert(
      'github_users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertGitHubRepos(List<GitHubRepo> repos) async {
    final db = await instance.database;
    Batch batch = db.batch();
    for (var repo in repos) {
      batch.insert(
        'github_repos',
        repo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return repos.length;
  }

  Future<List<GitHubUser>> getGitHubUsers() async {
    final db = await instance.database;
    final result = await db.query('github_users');
    return result.map((json) => GitHubUser.fromJson(json)).toList();
  }

  Future<List<GitHubRepo>> getGitHubRepos() async {
    final db = await instance.database;
    final result = await db.query('github_repos');
    return result.map((json) => GitHubRepo.fromJson(json)).toList();
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
