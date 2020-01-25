import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Main color of background
  final Color fMainColor = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fMainColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 120.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Animal Snap",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.camera_enhance,
                    size: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: InkWell(
                onTap: () {
                  print("Pressed");
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                      child: Icon(
                    Icons.play_arrow,
                    size: 70,
                    color: fMainColor,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
