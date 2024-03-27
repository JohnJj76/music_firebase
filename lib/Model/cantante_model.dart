import 'package:cloud_firestore/cloud_firestore.dart';

class CantanteModel {
  String? id;
  final String nombre;
  final String foto;
  final int canciones;
  CantanteModel(
      {this.id,
      required this.nombre,
      required this.foto,
      required this.canciones});

  factory CantanteModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CantanteModel(
        id: snapshot["id"],
        nombre: snapshot["nombre"],
        foto: snapshot["foto"],
        canciones: snapshot["canciones"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "foto": foto,
        "canciones": canciones
      };
}
