import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "all_animals.dart";
import 'constants.dart';
import 'package:http/http.dart' as http;

// The home page of the application
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
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
            Hero(
              tag: "bottom",
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: InkWell(
                  onTap: () async {
                    var animals = await fetchAnimals();

                    // Open all animals page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllAnimals(animals)),
                    );
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Icon(
                      Icons.play_arrow,
                      size: 70,
                      color: kMainColor,
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future fetchAnimals() async {
  final response = await http.get('http://159.65.231.125:5000/api/animals');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load animals. ${response.statusCode}');
  }
}
