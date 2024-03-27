import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_firebase/config/Colors.dart';
import 'package:music_firebase/controller/SongPlayerController.dart';

class fotoDetails extends StatelessWidget {
  const fotoDetails({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    SongPlayerController songPlayerController = Get.put(SongPlayerController());
    return Column(
      children: [
        SizedBox(height: 10),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), //1000
                  image: DecorationImage(
                      image: NetworkImage(songPlayerController.albumUrl.value),
                      fit: BoxFit.cover),
                  color: primaryColor,
                ),
              ),
              //
            ],
          ),
        )
      ],
    );
  }
}
