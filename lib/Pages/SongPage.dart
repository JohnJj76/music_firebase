import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_firebase/Model/cantante_model.dart';
import 'package:music_firebase/Pages/PlaySongPage.dart';
import 'package:music_firebase/components/SongTile.dart';
import 'package:music_firebase/components/TrendingSogSlider.dart';
import 'package:music_firebase/components/songHeader.dart';
import 'package:music_firebase/config/Colors.dart';
import 'package:music_firebase/controller/CloudSongController.dart';
import 'package:music_firebase/controller/SongPlayerController.dart';
import 'package:music_firebase/controller/songDataController.dart';

import 'datalles/cantante_detalle.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference _cantantes =
        FirebaseFirestore.instance.collection('cantantes');
    SongDataController songDataController = Get.put(SongDataController());
    SongPlayerController songPlayerController = Get.put(SongPlayerController());
    CloudSongController cloudSongController = Get.put(CloudSongController());
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SongPageHeader(),
              const SizedBox(height: 10),
              //const TrendingSongSlider(),

              //
              //
              //
              //////////////////////////////////////////////////////////////
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      color: Colors.white.withOpacity(0.07),
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: StreamBuilder(
                          stream: _cantantes.snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: streamSnapshot.data!.docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 260,
                                  ),
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    return GestureDetector(
                                      onTap: () {
                                        CantanteModel cantante = CantanteModel(
                                          id: documentSnapshot['id'],
                                          nombre: documentSnapshot['nombre'],
                                          foto: documentSnapshot['foto'],
                                          canciones:
                                              documentSnapshot['canciones'],
                                        );
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return CantanteDetalle(
                                              cantante: cantante);
                                        }));
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 182, 104, 104),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Image.network(
                                                      documentSnapshot['foto'],
                                                      width: 200,
                                                      height: 200,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    documentSnapshot['nombre'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                              ],
                                            ),
                                            const Positioned(
                                              top: 12,
                                              right: 12,
                                              child: Icon(Icons.favorite_border,
                                                  color: Colors.grey),
                                            ),
                                            const Align(
                                              alignment: Alignment.bottomRight,
                                              child: Material(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  bottomRight:
                                                      Radius.circular(16),
                                                ),
                                                child: InkWell(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Icon(Icons.add,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Container();
                          }),
                    ),

                    //
                    //
                    //
                  ],
                ),
              ),

              ////////////////////////////////////////////////
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          songDataController.isDeviceSong.value = false;
                        },
                        child: Text("musica online",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: songDataController.isDeviceSong.value
                                      ? lableColor
                                      : primaryColor,
                                ))),
                    InkWell(
                      onTap: () {
                        songDataController.isDeviceSong.value = true;
                      },
                      child: Text(
                        "Device Song",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: songDataController.isDeviceSong.value
                                  ? primaryColor
                                  : lableColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //
              //
              Obx(
                () => songDataController.isDeviceSong.value
                    ? Column(
                        children: songDataController.localSongList.value
                            .map((e) => SongTile(
                                  onPress: () {
                                    songPlayerController.playLocalAudio(e);
                                    songDataController
                                        .findCurrentSongPlayingIndex(e.id);
                                    Get.to(const PlaySongPage());
                                  },
                                  songName: e.title,
                                ))
                            .toList())
                    : Column(
                        children: cloudSongController.cloudSongList.value
                            .map((e) => SongTile(
                                  onPress: () {
                                    songPlayerController.playCloudAudio(e);
                                    songDataController
                                        .findCurrentSongPlayingIndex(e.id!);
                                    Get.to(PlaySongPage());
                                  },
                                  songName: e.title!,
                                ))
                            .toList(),
                      ),
              ),
              //
              //

              Obx(
                () => songDataController.isDeviceSong.value
                    ? Column(
                        children: songDataController.localSongList.value
                            .map((e) => SongTile(
                                  onPress: () {
                                    songPlayerController.playLocalAudio(e);
                                    songDataController
                                        .findCurrentSongPlayingIndex(e.id);
                                    Get.to(const PlaySongPage());
                                  },
                                  songName: e.title,
                                ))
                            .toList())
                    : Column(
                        //children: cloudSongController.cloudSongList.value.map((e) =>SongTile(
                        children: cloudSongController.trandingSongList.value
                            .map((e) => SongTile(
                                  onPress: () {
                                    songPlayerController.playCloudAudio(e);
                                    songDataController
                                        .findCurrentSongPlayingIndex(e.id!);
                                    Get.to(PlaySongPage());
                                  },
                                  songName: e.title!,
                                ))
                            .toList(),
                      ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
