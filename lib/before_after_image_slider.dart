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
///   * [dividerImage] is am [Image] and can be customised in any [Image] that is provided.
///   Default Image ([defaultDividerIcon]) is an Icon made by Freepik from www.flaticon.com, it's free to use and
///   can be checked at link here: https://www.flaticon.com/free-icon/up-and-down-arrows-button_59090
///
///   * [isDividerImageHidden] is a toggle [bool] for visibility of the divider Icon.
///   True if it's hidden, False if it's visible.
///   Default value is false.
///
///   * [dividerImageHeight] is the height of the divider.
///   Default value is 50.0.
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
  final Image defaultDividerIcon = Image.asset("assets/images/slider_icon.png",
      package: "before_after_image_slider");
  final Image dividerImage;

  final double dividerImageHeight;
  final double dividerThickness;

  final Color dividerColor;

  final bool isDividerImageHidden;

  BeforeAfterImage({
      @required this.beforeImage,
      @required this.afterImage,
      this.dividerImage,
      this.isDividerImageHidden = false,
      this.dividerImageHeight = 50.0,
      this.dividerThickness = 5.0,
      this.dividerColor = Colors.black12
  }) : assert(beforeImage != null),
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
                  double height = (snapshot.data.height / snapshot.data.width) * width;
                  return Transform(
                      transform: Matrix4.translationValues(
                          dxValue - width / 2, 0.0, 0.0),
                      child: Stack(children: <Widget>[
                        Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height,
                              width: widget.dividerThickness,
                              color: widget.dividerColor,
                            )),
                        Positioned(
                            child: getSliderImage(widget),
                            height: widget.dividerImageHeight,
                            left: width / 2 - widget.dividerImageHeight / 2,
                            bottom: snapshot.data.height / 2)
                      ]));
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

  getSliderImage(BeforeAfterImage widget) {
    if (widget.isDividerImageHidden) {
      return Container();
    } else if (widget.dividerImage == null) {
      return widget.defaultDividerIcon;
    } else {
      return widget.dividerImage;
    }
  }
}
