import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_bloc/constants/db_constants.dart';
import 'package:first_bloc/models/custom_error.dart';
import 'package:first_bloc/models/todo_model.dart';

class TodoRepository {
  final FirebaseFirestore firebaseFirestore;
  TodoRepository({
    required this.firebaseFirestore,
  });
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addTodo(String desc) async {
    try {
      final User user = auth.currentUser!;
      final uid = user.uid;
      final todoID = DateTime.now().toString();

      await usersTodo.doc(uid).update({
        "todos": FieldValue.arrayUnion(
          [
            {
              'id': todoID,
              'description': desc,
              'completed': false,
            }
          ],
        )
      });
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<dynamic> readTodo() async {
    try {
      final User user = auth.currentUser!;
      final uid = user.uid;

      DocumentSnapshot documentSnapshot = await usersTodo.doc(uid).get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map;

        return data['todos'];
      }
      throw 'Todo not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> editTodo(String id, String desc) async {}

  Future<void> toggleTodo(
    String id,
  ) async {}

  Future<void> removeTodo(Todo todo) async {}
}
