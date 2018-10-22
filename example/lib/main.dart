import 'package:flutter/material.dart';
import 'package:before_after_image_slider/before_after_image_slider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Container(
              child: BeforeAfterImage(
                  beforeImage: Image.network(
                      'https://cdn.images.express.co.uk/img/dynamic/galleries/x701/59626.jpg'),
                  afterImage: Image.network(
                      'https://cdn.images.express.co.uk/img/dynamic/galleries/x701/59640.jpg')),
            )));
  }
}
