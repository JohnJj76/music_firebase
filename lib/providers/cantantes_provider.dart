import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_firebase/Model/cantante_model.dart';

class CantantesProvider with ChangeNotifier {
  late CantanteModel itemModel;

  List<CantanteModel> search = [];

  productModels(QueryDocumentSnapshot element) {
    itemModel = CantanteModel(
      id: element.get("id"),
      nombre: element.get("nombre"),
      foto: element.get("foto"),
      canciones: element.get("canciones"),
    );
    search.add(itemModel);
  }

  /////////////// herbsProduct ///////////////////////////////
  List<CantanteModel> herbsProductList = [];

  fatchHerbsProductData() async {
    List<CantanteModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("cantantes").get();

    value.docs.forEach(
      (element) {
        productModels(element);

        newList.add(itemModel);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<CantanteModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  /////////////////// Search Return ////////////
  List<CantanteModel> get gerAllProductSearch {
    return search;
  }

  ///////

}
