import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_firebase/Model/MySongModel.dart';
import 'package:music_firebase/Model/cantante_model.dart';

class CloudSongController extends GetxController {
  final db = FirebaseFirestore.instance;

  RxList<MySongModel> cloudSongList = RxList<MySongModel>([]);
  RxList<MySongModel> trandingSongList = RxList<MySongModel>([]);

  @override
  void onInit() {
    //subirSongToDB();
    //subirCantante();
    getCloudSound();
    // TODO: implement onInit
    super.onInit();
  }

  void uploadSongToDB() async {
    MySongModel newSong = MySongModel(
      id: 1,
      title: "Suni-Nahi-Zamane-Ne-Teri-Meri-Kahaani(PagalWorld)",
      artist: "Jubain Nautiyal",
      album: "album",
      albumArt:
          "https://c.saavncdn.com/586/Dil-Kahe-Hindi-2020-20200904224534-500x500.jpg",
      data:
          "https://firebasestorage.googleapis.com/v0/b/musicplayer-3d5a1.appspot.com/o/Suni-Nahi-Zamane-Ne-Teri-Meri-Kahaani(PagalWorld).mp3?alt=media&token=6e095a5f-87b6-4ad8-96f6-4d67ffaf9140&_gl=1*uz8ayw*_ga*MTUwODI2NDM0LjE2OTc3OTYyODk.*_ga_CW55HF8NVT*MTY5ODQxODI2MC4yLjEuMTY5ODQyNDQ0NS42MC4wLjA.",
    );

    await db.collection("tranding").add(newSong.toJson());
    print("😍 Song upload to Database  😍");
  }

  void subirSongToDB() async {
    MySongModel newSong = MySongModel(
      id: 1,
      title: "Abres camino",
      artist: "Marcela Gandara",
      album: "album",
      albumArt:
          "https://c.saavncdn.com/586/Dil-Kahe-Hindi-2020-20200904224534-500x500.jpg",
      data:
          "https://firebasestorage.googleapis.com/v0/b/music-firebase-3671d.appspot.com/o/adoraciones%2FMarcelaGandara%2FAbres%20Camino.mp3?alt=media&token=2d9e6fc2-d678-4bec-b46c-413212c9d1c7",
    );
    await db.collection("songs").add(newSong.toJson());
    print("😍 subido con exito  😍");
  }

  void subirCantante() async {
    CantanteModel newCantante = CantanteModel(
      id: "3",
      nombre: "Marcos Witt",
      foto:
          "https://res.cloudinary.com/dpkl8ht0e/image/upload/v1711467432/cantantes/rhkpmyumznsyb3abvnti.jpg",
      canciones: 0,
    );
    await db.collection("cantantes").add(newCantante.toJson());
    print("😍 cantante subido con exito  😍");
  }

  void getCloudSound() async {
    cloudSongList.clear();
    await db.collection("songs").get().then((value) {
      value.docs.forEach((element) {
        cloudSongList.add(MySongModel.fromJson(element.data()));
      });
    });
    await db.collection("tranding").get().then((value) {
      value.docs.forEach((element) {
        trandingSongList.add(MySongModel.fromJson(element.data()));
      });
    });
  }
}
