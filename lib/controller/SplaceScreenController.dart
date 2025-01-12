import 'package:get/get.dart';
import 'package:music_firebase/Pages/SongPage.dart';

class SplaceScreenController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3),(){
      Get.offAll(SongPage());
    });
  }
}