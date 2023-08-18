import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/services/mesaje.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:provider/provider.dart';

import '../../../models/mensaje.dart';

// ignore: must_be_immutable
class RevisarImg extends StatelessWidget {
  final File? image;
  RevisarImg({required this.image, super.key});
  User tempUser = User();
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UsersData>(context);
    final mensaje = Provider.of<MensajeService>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
            child: const Text(
              "OK",
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              final uriImg = await userdata.upLoadImg(image!);

              tempUser = userdata.users[0].copyWith(
                urlImagen: uriImg,
              );

              await userdata.updateUser(tempUser);
              userdata.load();
            }),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.file(image!, fit: BoxFit.cover),
          ),
        ));
  }
}

class RevisarImg1 extends StatelessWidget {
  final File? image;
  RevisarImg1({required this.image, super.key});
  User tempUser = User();
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UsersData>(context);
    final mensaje = Provider.of<MensajeService>(context);
    mensaje.cargarId(context);
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
            child: const Text(
              "OK",
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              final uriImg = await userdata.upLoadImg(image!);

              await mensaje.crearProduct(Mensaje(
                fecha: "18/8/2023",
                contenido: "Lol",
                urlImagen: uriImg,
              ));
              userdata.load();
            }),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.file(image!, fit: BoxFit.cover),
          ),
        ));
  }
}
