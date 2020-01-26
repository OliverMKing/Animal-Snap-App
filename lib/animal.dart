import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Animal extends StatelessWidget {
  Animal(this.animal, this.number);

  final animal;
  final number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 20.0, left: 30.0, right: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            number,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${animal["name"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${animal["class"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                      padding:
                          EdgeInsets.only(top: 20.0, right: 15.0, bottom: 20.0),
                      child: Image.network(
                        animal["image-url"],
                        fit: BoxFit.scaleDown,
                      )),
                )
              ],
            ),
            Expanded(
              child: Hero(
                tag: "bottom",
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${animal["description"]}'),
                                    ],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: kMainColor,
                          onPressed: () async {
                            String url = animal["wikipedia-url"];
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: const Text('Read More on Wikipedia',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ],
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
