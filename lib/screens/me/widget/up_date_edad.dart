import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymtesis/constanst.dart';
import 'package:gymtesis/models/users.dart';
import 'package:gymtesis/services/user_data.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpDateEdad extends StatefulWidget {
  String fullName;
  UpDateEdad({
    required
    this.fullName ,super.key});

  @override
  State<UpDateEdad> createState() => _UpDateEdadState();
}

class _UpDateEdadState extends State<UpDateEdad> {
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
    myController3.text = widget.fullName.toString();
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
                "Actualizar Edad",
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                // inputFormatters: [maskFormatter],
                                controller: myController3,
                                autocorrect: false,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(13),
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 2)),
                                    filled: true,
                                    fillColor: primaryColor,
                                    hintText: '',
                                    labelText: "Edad",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                ),
                                onChanged: (value) =>
                                    myController3.text = value,
                                validator: (value) {
                                  return (value!.isNotEmpty &&
                                          value.isNotEmpty)
                                      ? null
                                      : 'Ingrese tu Edad';
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
                 
                  );

                  await userdata.updateUser(tempUser);
                  userdata.load();
                  // ignore: use_build_context_synchronously
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
  

