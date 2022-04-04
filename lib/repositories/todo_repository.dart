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

  Future<String> addTodo(String desc) async {
    try {
      // Uuid uuid = Uuid();
      final User user = auth.currentUser!;
      final uid = user.uid;
      final todoID = DateTime.now().toString();

      await usersRef.doc(uid).collection('todos').doc('todos').set(
        {
          todoID: {
            'id': todoID,
            'description': desc,
            'completed': false,
          }
        },
        SetOptions(merge: true),
      );
      return todoID;
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

      DocumentSnapshot documentSnapshot =
          await usersRef.doc(uid).collection('todos').doc('todos').get();
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map;

        return data;
      }
      ;
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

  Future<void> removeTodo(Todo todo) async {
    try {} on FirebaseException catch (e) {
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

  Future<void> editTodo(String id, String desc) async {
    try {} on FirebaseException catch (e) {
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

  Future<void> toggleTodo(
    String id,
  ) async {}
}
