import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final FirebaseAuth authTodoRepo = FirebaseAuth.instance;
Color themeLightColor = Color(0xffE6D5B8);
Color themeDarkColor = Color(0xff395B64);
Map<String, double> kFontSize = {
  'size20': 20,
  'size23': 23,
  'size26': 26,
  'size29': 29,
  'size32': 32,
  'size35': 35,
};

Map<String, double> kCardSize = {
  'height80': 80,
  'height90': 90,
  'height100': 100,
  'height105': 105,
  'height110': 110,
  'height120': 120,
};
