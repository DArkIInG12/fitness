import 'package:cloud_firestore/cloud_firestore.dart';

class ExercisesFirebase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insert(Map<String, dynamic> datos, String colection) async {
    try {
      await firestore.collection(colection).add(datos);
    } catch (e) {
      print('Error al enviar datos: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDocsEquals(
      String colection, String field, String value) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(colection);

    QuerySnapshot snapshot =
        await collection.where(field, isEqualTo: value).get();
    List<Map<String, dynamic>> list =
        snapshot.docs.map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }).toList();

    return list;
  }

    Future<List<Map<String, dynamic>>> getDocsEqualsLImit(
      String colection, String field, String value,int limit) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(colection);

    QuerySnapshot snapshot =
        await collection.where(field, isEqualTo: value).orderBy('date' ,descending: true).limit(limit).get();
    List<Map<String, dynamic>> list =
        snapshot.docs.map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }).toList();

    return list;
  }


}
