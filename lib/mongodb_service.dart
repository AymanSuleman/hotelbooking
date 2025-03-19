// import 'package:mongo_dart/mongo_dart.dart';

// class MongoDatabase {
//   static var db, collection;

//   static Future<void> connect() async {
//     db = await Db.create("mongodb://localhost:27017/backend");
//     await db.open();

//     collection = db.collection("backend");
//     print("Connected to MongoDB Compass ✅");
//   }

//   static Future<List<Map<String, dynamic>>> getData() async {
//     final data = await collection.find().toList();
//     return data;
//   }

//   static Future<void> insertData(Map<String, dynamic> data) async {
//     await collection.insertOne(data);
//     print("Data Inserted ✅");
//   }
// }

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static const String MONGO_URL = "mongodb://127.0.0.1:27017/backend";
  static const String COLLECTION_NAME = "users";

  static Future<void> connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    print("Connected to MongoDB");
  }

  static Future<void> insertUser(Map<String, dynamic> user) async {
    var collection = db.collection(COLLECTION_NAME);
    await collection.insert(user);
  }

  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    var collection = db.collection(COLLECTION_NAME);
    return await collection.find().toList();
  }
}
