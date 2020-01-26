import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'constants.dart';
import 'camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AllAnimals extends StatefulWidget {
  AllAnimals(this.animals, this.firstCamera, this.prefs);

  final animals;
  final CameraDescription firstCamera;
  final SharedPreferences prefs;

  @override
  _AllAnimalsState createState() => _AllAnimalsState();
}

class _AllAnimalsState extends State<AllAnimals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        child: Icon(Icons.camera_enhance),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Camera(widget.firstCamera)),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 30.0, right: 30.0, bottom: 20.00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Animals",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w500),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Seen",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "${widget.prefs.getKeys().length} / ${widget.animals.length}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Hero(
                tag: "bottom",
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 1, left: 16, right: 16, bottom: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Scrollbar(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: ListView.builder(
                          itemCount: widget.animals.length,
                          itemBuilder: (BuildContext context, int index) {
                            var name = widget.animals[index]["name"];
                            bool seen = widget.prefs.containsKey(name);

                            return Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${(index + 1).toString().padLeft(3, '0')}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    SizedBox(width: 60),
                                    Text(
                                      '$name',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      seen ? Icons.check : Icons.clear,
                                      color: seen ? Colors.green : Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
