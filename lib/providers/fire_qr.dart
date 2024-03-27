import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// LEER
Future<List> listarArt(String idArtista) async {
  List listaqr = [];
  CollectionReference collectionReference = _firestore.collection('songs');
  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    if (documento['albumArt'].toString() == idArtista) {
      listaqr.add(documento.data());
    }
  });
  return listaqr;
}



