import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Initial db
  static Future<Database> db() async {
    return openDatabase(
      'buku_kas.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTableTransaction(database);
        await createTableUser(database);
        await insertDataUser(database);
      },
    );
  }

  // Create table transaction
  static Future<void> createTableTransaction(Database database) async {
    await database.execute("""
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        nominal INTEGER,
        description TEXT,
        category TEXT
      )
    """);
  }

  // Create table user
  static Future<void> createTableUser(Database database) async {
    await database.execute("""
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        username TEXT,
        password TEXT,
        photo TEXT
      )
    """);
  }

  // Insert single data user
  static Future<void> insertDataUser(Database database) async {
    await database.execute("""
      INSERT INTO users (name, username, password, photo) VALUES 
      ('Zulfia Lutfiani', 'zulfia', '1234', 'assets/images/profil.jpg')
    """);
  }

  // Login
  static Future<List<Map<String, dynamic>>> login(
      String username, String password) async {
    final db = await DbHelper.db();
    final data = db.query('users',
        columns: ['id'],
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
        limit: 1);

    return data;
  }

  // Get user login
  static Future<List<Map<String, dynamic>>> userLoggedIn(int? id) async {
    final db = await DbHelper.db();
    final data = db.query('users', where: 'id = ?', whereArgs: [id], limit: 1);

    return data;
  }

  // Create new transaction
  static Future<int> createTransaction(
    String date,
    int nominal,
    String description,
    String category,
  ) async {
    final db = await DbHelper.db();

    final data = {
      'date': date,
      'nominal': nominal,
      'description': description,
      'category': category,
    };

    final id = await db.insert(
      'transactions',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  // Fetch all data
  static Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final db = await DbHelper.db();
    return db.query('transactions', orderBy: 'id DESC');
  }

  // Calculate total income
  static Future<List<Map<String, dynamic>>> calculateTransaction(
      String category) async {
    final db = await DbHelper.db();
    final data = await db.rawQuery(
        "SELECT SUM(nominal) as total FROM transactions WHERE category = '$category'");

    return data;
  }

  // Change password
  static Future<bool> changePassword(
      int id, String oldPassword, String newPassword) async {
    final db = await DbHelper.db();

    // Check old password
    final oldPass = await db.query(
      'users',
      columns: ['password'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (oldPass[0]['password'] == oldPassword) {
      final data = {
        'password': newPassword,
      };

      await db.update(
        'users',
        data,
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } else {
      return false;
    }
  }
}
