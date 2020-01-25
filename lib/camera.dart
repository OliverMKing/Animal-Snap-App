import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Camera extends StatefulWidget {
  Camera(this.firstCamera);

  final CameraDescription firstCamera;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 30.0, right: 30.0, bottom: 20.00),
              child: Text(
                "Take a Picture of the Animal",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return CameraPreview(_controller);
                  } else {
                    // Otherwise, display a loading indicator.
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        backgroundColor: kMainColor,
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            await _controller.takePicture(path);

            print("Picture taken");

            // Submit picture
            var postUri = Uri.parse("http://159.65.231.125:5000/api/path");
            var request = new http.MultipartRequest("POST", postUri);
            request.files.add(new http.MultipartFile.fromBytes(
                'file', await File.fromUri(Uri.parse(path)).readAsBytes(),
                contentType: new MediaType('avatar', 'jpeg')));

            request.send().then((response) {
              if (response.statusCode == 200) print("Uploaded!");
            });
          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
