import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:trackcam/widgets/normal_text.dart';class TrackingScreen extends StatelessWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back)),

            Align(
              alignment: Alignment.center,
              child: NormalText(text: 'Live Tracking', size: 18),
            )
            ],
        ),
      )
    );
  }
}
