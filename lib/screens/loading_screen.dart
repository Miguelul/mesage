

import 'package:flutter/material.dart';
import 'package:gymtesis/constanst.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        )
      ),
    );
  }
}