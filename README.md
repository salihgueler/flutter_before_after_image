#  Before After Image

**BeforeAfterImage** is a Flutter plugin to create a Before-After view with stacked two images and give user experience about before and after view.

![Alt Text](https://github.com/salihgueler/flutter_before_after_image/blob/master/resource/preview.gif)

## How to use?

You can simply use it by adding two images to **beforeImage** and **afterImage** values.

**dividerThickness** and **dividerColor** can be modified too. These two values have default values of **5.0** for dividerThickness and **Colors.black12** for dividerColor.

```
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
```

## TODOs
- Add Landscape mode support.
- Add icon for slider.
- Tests

## License

#### salihgueler/flutter_before_after_image repository is licensed under the Apache License 2.0

A permissive license whose main conditions require preservation of copyright and license notices. Contributors provide an express grant of patent rights. Licensed works, modifications, and larger works may be distributed under different terms and without source code.

For more information about license, check  `LICENSE`  file.

