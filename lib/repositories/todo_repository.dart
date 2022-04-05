import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_bloc/constants/db_constants.dart';
import 'package:first_bloc/models/custom_error.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  final FirebaseFirestore firebaseFirestore;
  TodoRepository({
    required this.firebaseFirestore,
  });

  String get _userUid {
    final User user = authTodoRepo.currentUser!;
    final uid = user.uid;
    return uid;
  }

  Future<String> addTodo(String desc) async {
    try {
      Uuid uuid = Uuid();
      final todoID = uuid.v4();

      await usersRef.doc(_userUid).collection('todos').doc('todos').set(
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
      DocumentSnapshot documentSnapshot =
          await usersRef.doc(_userUid).collection('todos').doc('todos').get();
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

  Future<void> removeTodo(String id) async {
    try {
      await usersRef
          .doc(_userUid)
          .collection('todos')
          .doc('todos')
          .update({id: FieldValue.delete()})
          .then((value) => print("User's Property Deleted"))
          .catchError(
              (error) => print("Failed to delete user's property: $error"));
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

  Future<void> editTodo(String id, String desc, bool completed) async {
    try {
      await usersRef
          .doc(_userUid)
          .collection('todos')
          .doc('todos')
          .update({
            id: {
              'id': id,
              'description': desc,
              'completed': completed,
            }
          })
          .then((value) => print("Todos desc updated"))
          .catchError(
              (error) => print("Failed to delete user's property: $error"));
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

  Future<void> toggleTodo(Todo t) async {
    try {
      await usersRef
          .doc(_userUid)
          .collection('todos')
          .doc('todos')
          .update({
            t.id: {
              'id': t.id,
              'description': t.description,
              'completed': !t.completed,
            }
          })
          .then((value) => print("Todos completed updated"))
          .catchError(
              (error) => print("Failed to delete user's property: $error"));
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
}
