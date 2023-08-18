import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymtesis/provider/validator_form.dart';
import 'package:gymtesis/screens/me/widget/revisar_img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../services/user_data.dart';

class CircularAbata extends StatefulWidget {
  const CircularAbata({super.key});

  @override
  State<CircularAbata> createState() => _CircularAbataState();
}

class _CircularAbataState extends State<CircularAbata> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UsersData>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Stack(children: [
        SizedBox(
            width: 140,
            height: 140,
            child: Center(
              child: CircleAvatar(
                radius: 60,
                child: ClipRRect (
                borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                  width: 120,
                  height: 120,
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : userdata.users[0].urlImagen !=""? Image.network(userdata.users[0].urlImagen!,fit: BoxFit.cover):Image.asset("assets/img/R (5).jpg",fit: BoxFit.cover),
                )),
              ),
            )),
        Positioned(
            right: 9,
            bottom: 9,
            child: GestureDetector(
                onTap: () async {
               
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                  
                      _image = File(pickedImage.path);
                       Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: ChangeNotifierProvider(
                                                create: (context) =>
                                                    ValidatorForm(),
                                                child:  RevisarImg(image: _image),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                    
                  
                  } else {
                  
                  }
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(CupertinoIcons.camera_fill))))
    
      ]),
    );
  }
}