import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:music_firebase/Model/cantante_model.dart';
import 'package:music_firebase/Model/item_cancion_model.dart';
import 'package:music_firebase/components/SongTile.dart';
import 'package:music_firebase/config/Colors.dart';
import 'package:music_firebase/controller/CloudSongController.dart';
import 'package:music_firebase/controller/SongPlayerController.dart';
import 'package:music_firebase/controller/songDataController.dart';
import 'package:music_firebase/providers/cancionesList_provider.dart';
import 'package:music_firebase/providers/fire_qr.dart';
import 'package:provider/provider.dart';

class CantanteDetalle extends StatefulWidget {
  const CantanteDetalle({
    super.key,
    required this.cantante,
  });
  final CantanteModel cantante;

  @override
  State<CantanteDetalle> createState() => _CantanteDetalleState();
}

class _CantanteDetalleState extends State<CantanteDetalle> {
  int quantity = 1;

  CloudSongController cloudSongController = Get.put(CloudSongController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          const SizedBox(height: 10),
          header(),
          const SizedBox(height: 5),
          image(),
          details(),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: const BackButton(color: Colors.white),
          ),
          const Spacer(),
          Text(
            widget.cantante.nombre,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Material(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                child: const Icon(Icons.star, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  widget.cantante.foto,
                  width: 280,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container details() {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cantante.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /*
          Obx(
            () => Column(
              children: cloudSongController.cloudSongList.value
                  .map((e) => SongTile(
                        onPress: () {
                          /*
                                    songPlayerController.playCloudAudio(e);
                                    songDataController
                                        .findCurrentSongPlayingIndex(e.id!);
                                    Get.to(PlaySongPage());
                                    */
                        },
                        songName: e.title!,
                      ))
                  .toList(),
            ),
          ),
          */
          /*
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // AGREGAR AL CARRITO
                if (quantity > 0) {
                  CartModel qr = CartModel(
                    id: widget.food.id,
                    nombre: widget.food.nombre,
                    descripcion: widget.food.descripcion,
                    imagen: widget.food.imagen,
                    precio: int.parse(widget.food.precio.toString()),
                    cantidad: quantity,
                  );
                  // ToDO: Adding a studen
                  /*context
                      .read<CartProvider>()
                      .addItem(widget.food, quantity, user.uid);*/
                  context.read<CartProvider>().agregarOrden(qr, quantity);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(_buildSnackBar(context));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(_buildSnackBar(context, haveError: true));
                }
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: const Text(
                  'Agregar al Carrito',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          */
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

SnackBar _buildSnackBar(BuildContext context, {bool haveError = false}) =>
    SnackBar(
      //on tap => open cartPage
      backgroundColor: haveError ? Colors.red : Color(0xFF34C759),
      duration: const Duration(milliseconds: 1500),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            haveError
                ? "La cantidad debe ser mayor que cero."
                : "Agregado al carrito correctamente.",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          if (!haveError)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "cart",
                  (route) => false,
                );
              },
              child: const Text("Open Cart"),
            )
        ],
      ),
    );
