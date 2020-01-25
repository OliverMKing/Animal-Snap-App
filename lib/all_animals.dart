import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'constants.dart';
import 'camera.dart';

class AllAnimals extends StatelessWidget {
  AllAnimals(this.animals, this.firstCamera);

  final animals;
  final CameraDescription firstCamera;

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
            MaterialPageRoute(builder: (context) => Camera(firstCamera)),
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
                        "0 / ${animals.length}",
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
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ListView.builder(
                      itemCount: animals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                          leading:
                              Text("${(index + 1).toString().padLeft(3, '0')}"),
                          title: Text('${animals[index]["name"]}'),
                          trailing: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ));
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
