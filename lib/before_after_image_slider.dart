library before_after_image_slider;

import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

/// BeforeAfterImage is a class to create a slider to have a before and after
/// image effect.
///
/// It requires two variables [beforeImage] and [afterImage].
/// [beforeImage] is placed on top of [afterImage]
///
/// It can be customised with the options below:
///
///   * [dividerThickness] is the width of the divider.
///   Default value is 5.0
///
///   * [dividerColor] is the color of the divider.
///   Default value is [Colors.black12]
///
///
class BeforeAfterImage extends StatefulWidget {

  final Image beforeImage;
  final Image afterImage;

  final double dividerThickness;

  final Color dividerColor;

  BeforeAfterImage(
      {@required this.beforeImage,
      @required this.afterImage,
      this.dividerThickness = 5.0,
      this.dividerColor = Colors.black12})
      : assert(beforeImage != null),
        assert(afterImage != null);

  @override
  BeforeAfterImageState createState() => new BeforeAfterImageState();
}

class BeforeAfterImageState extends State<BeforeAfterImage> {
  static const fullScreenPercentage = 1.0;

  // Initial value to start the view from.
  double initialWidthPercentage = 0.5;
  double dxValue = 0.0;
  bool isInitState = true;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (isInitState) {
      dxValue = width / 2;
    }
    // Listen for image to load and get the width and height of the image at the
    // FutureBuilder below.
    Completer<ui.Image> completer = new Completer<ui.Image>();
    widget.beforeImage.image.resolve(new ImageConfiguration()).addListener(
        (ImageInfo info, bool _) => completer.complete(info.image));

    return new Container(
      child: GestureDetector(
          onHorizontalDragDown: (DragDownDetails details) {
            setState(() {
              onSliderMove(details.globalPosition.dx, width);
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            setState(() {
              onSliderMove(details.globalPosition.dx, width);
            });
          },
          child: Stack(children: [
            widget.afterImage,
            // Align the before image to right to be able to keep it on the rightside.
            Align(
              alignment: Alignment.topRight,
              child: ClipRect(
                child: Align(
                    alignment: Alignment.topRight,
                    widthFactor: fullScreenPercentage - initialWidthPercentage,
                    child: widget.beforeImage),
              ),
            ),
            FutureBuilder<ui.Image>(
              future: completer.future,
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (snapshot.hasData) {
                  // Get the ratio of height and width for the beforeImage
                  // and calculate the related height according to screen width
                  double height =
                      (snapshot.data.height / snapshot.data.width) * width;
                  return Transform(
                    transform: Matrix4.translationValues(
                        dxValue - width / 2, 0.0, 0.0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: height,
                          width: widget.dividerThickness,
                          color: widget.dividerColor,
                        )),
                  );
                } else {
                  return Container();
                }
              },
            )
          ])),
    );
  }

  void onSliderMove(double xCoordinate, double width) {
    dxValue = xCoordinate;
    initialWidthPercentage = xCoordinate / width;
    isInitState = false;
  }
}
