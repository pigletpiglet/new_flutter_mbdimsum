import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseHelper {
  static bool production = false;

  final instance = FirebaseFirestore.instance;

  String get route;

  String get collectionPath => route + (production ? "" : "_dev");
}
