import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  // Get a list of animals
  final animals = await fetchAnimals();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Animal Snap',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Home(firstCamera, animals, prefs),
  ));
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
