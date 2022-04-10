import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final FirebaseAuth authTodoRepo = FirebaseAuth.instance;
Color themeLightColor = Color(0xffE6D5B8);
Color themeDarkColor = Color(0xff395B64);
