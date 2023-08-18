import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RevisarImg extends StatelessWidget {
  final File? image;
  RevisarImg({required this.image, super.key});
  User tempUser = User();
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UsersData>(context);
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
                img: uriImg,
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
