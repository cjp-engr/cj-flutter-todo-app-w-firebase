import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final usersTodo = FirebaseFirestore.instance.collection('todo');
