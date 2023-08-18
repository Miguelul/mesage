import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymtesis/constanst.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/screens/me/widget/revisar_img.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../provider/validator_form.dart';

// ignore: must_be_immutable
class UpDate extends StatefulWidget {
  String fullName;
  UpDate({required this.fullName, super.key});

  @override
  State<UpDate> createState() => _UpDateState();
}

class _UpDateState extends State<UpDate> {
  final myController = TextEditingController();

  final myController2 = TextEditingController();

  TextEditingController myController3 = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  TextEditingController timeinput = TextEditingController();

  User tempUser = User();
  @override
  void initState() {
    // TODO: implement initState
    myController3.text = widget.fullName;
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    //  final validatorForm = Provider.of<ValidatorForm>(context);

    final userdata = Provider.of<UsersData>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cambiar Nombre",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                width: width - 40,
                height: 115,
                decoration: const BoxDecoration(
                  // color: kSeconColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width - 40,
                      height: 110,
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                // inputFormatters: [maskFormatter],
                                controller: myController3,
                                autocorrect: false,
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2)),
                                  filled: true,
                                  fillColor: primaryColor,
                                  hintText: '',
                                  labelText: "Nombre Completo",
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                                onChanged: (value) =>
                                    myController3.text = value,
                                validator: (value) {
                                  return (value!.isNotEmpty && value.isNotEmpty)
                                      ? null
                                      : 'Ingrese tu Nombre';
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              CupertinoButton(
                color: kPrimaryColor,
                disabledColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                onPressed: () async {
                  tempUser = userdata.users[0].copyWith(
                    nombre: myController3.text,
                  );

                  await userdata.updateUser(tempUser);
                  userdata.load();
                  Navigator.of(context).pop();
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class UpDate2 extends StatefulWidget {
  String fullName;
  UpDate2({required this.fullName, super.key});

  @override
  State<UpDate2> createState() => _UpDate2State();
}

class _UpDate2State extends State<UpDate2> {
  final myController = TextEditingController();

  final myController2 = TextEditingController();
  File? _image;
  TextEditingController myController3 = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  TextEditingController timeinput = TextEditingController();

  User tempUser = User();
  @override
  void initState() {
    // TODO: implement initState
    myController3.text = widget.fullName;
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    //  final validatorForm = Provider.of<ValidatorForm>(context);

    final userdata = Provider.of<UsersData>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Hacer Post",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      width: width - 40,
                      height: 140,
                      decoration: const BoxDecoration(
                        // color: kSeconColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width - 40,
                            // height: 240,
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TextFormField(
                                      // inputFormatters: [maskFormatter],
                                      maxLines: 4,
                                      controller: myController3,
                                      autocorrect: false,
                                      obscureText: false,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            borderSide: const BorderSide(
                                                color: kPrimaryColor,
                                                width: 2)),
                                        filled: true,
                                        fillColor: primaryColor,
                                        hintText: '',
                                        labelText: "Post",
                                        labelStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      onChanged: (value) =>
                                          myController3.text = value,
                                      validator: (value) {
                                        return (value!.isNotEmpty &&
                                                value.isNotEmpty)
                                            ? null
                                            : 'Ingrese tu Nombre';
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedImage != null) {
                            _image = File(pickedImage.path);
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return FadeTransition(
                                    opacity: animation1,
                                    child: ChangeNotifierProvider(
                                      create: (context) => ValidatorForm(),
                                      child: RevisarImg1(image: _image),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {}
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(CupertinoIcons.camera_on_rectangle_fill))),
                 const   SizedBox(
                      height: 200,
                    ),
                    CupertinoButton(
                      color: kPrimaryColor,
                      disabledColor: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      onPressed: () async {
                        tempUser = userdata.users[0].copyWith(
                          nombre: myController3.text,
                        );

                        await userdata.updateUser(tempUser);
                        userdata.load();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Postear'),
                    ),
                  ],
                )),
          ),
        ));
  }
}
