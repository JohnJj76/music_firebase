import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_firebase/Model/item_cancion_model.dart';

class CancionesListProvider with ChangeNotifier {
  late ItemCancionModel itemCanModel;

  List<ItemCancionModel> search = [];

  productModels(QueryDocumentSnapshot element) {
    itemCanModel = ItemCancionModel(
      id: element.get("id"),
      title: element.get("title"),
      artist: element.get("artist"),
      album: element.get("album"),
      albumArt: element.get("albumArt"),
      data: element.get("data"),
    );
    search.add(itemCanModel);
  }

  /////////////// lista de canciones de un artista ///////////////////////////////
  List<ItemCancionModel> herbsProductList = [];

  listaPorArtistaData(String idArt) async {
    List<ItemCancionModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("cantantes").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        print(element);

        newList.add(itemCanModel);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<ItemCancionModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  /////////////////// Search Return ////////////
  List<ItemCancionModel> get gerAllProductSearch {
    return search;
  }

  ///////
  ///
  ///
  ///
  ///
  ///
  ///
// octener listado de mi carrito

  List<ItemCancionModel> cartDataList = [];

  void getReviewCartData(String idArtista) async {
    List<ItemCancionModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("songs")
        .where("albumArt", isEqualTo: idArtista)
        .get();
    reviewCartValue.docs.forEach((element) {
      ItemCancionModel reviewCartModel = ItemCancionModel(
        id:element.get("id"),
        title: element.get("title"),
        artist: element.get("artist"),
        album: element.get("album"),
        albumArt: element.get("albumArt"),
        data: element.get("data"),
      );
      newList.add(reviewCartModel);
    });
    cartDataList = newList;
    notifyListeners();
  }


}
