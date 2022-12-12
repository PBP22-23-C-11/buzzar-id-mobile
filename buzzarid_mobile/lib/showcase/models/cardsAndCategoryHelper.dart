import 'package:flutter/material.dart';
import 'dart:ui' as ui;


final List<String> categories = [
  "All",
  "Food and Beverages",
  "Fashion",
  "Agriculture",
  "Electronic",
  "Furniture",
  "Service",
  "Other",
];

final Map<String, List<Color>> catCol = {
  "All":[const Color(0xff6DC8F3), const Color(0xff73A1F9)],
  "Food and Beverages":[const Color(0xffFFB157), const Color(0xffFFA057)],
  "Fashion":[const Color(0xffFF5B95), const Color(0xffF8556D)],
  "Agriculture":[const Color(0xffD76EF5), const Color(0xff8F7AFE)],
  "Electronic":[const Color(0xff42E695), const Color(0xff3BB2B8)],
  "Furniture":[const Color(0xff6DC8F3), const Color(0xff73A1F9)],
  "Service":[const Color(0xffFFB157), const Color(0xffFFA057)],
  "Other":[const Color(0xffFF5B95), const Color(0xffF8556D)]
};

final Map<String, String> explanation = {
  "All":"View A Plethora Of UMKMs To Get Interested At",
  "Food and Beverages":"Indulge In Our Collection Of FnBs, And Don't Forget To Order!",
  "Fashion":"A Trendsetter, Icon, Center Of Spotlight, Anything You Name It! We Will Make You One With Our Finest Collections",
  "Agriculture":"Become A Garden Zen, And Be One With Nature",
  "Electronic":"Get The Latest And Greatest Inventions At Technology",
  "Furniture":"Just Moved In? Or Redesigning? Check Out These UMKMs For Inspirations!",
  "Service":"Too Lazy To Do Chores, Labors, Or Anything Really? Reach Out To Us!",
  "Other":"Out Of The Box UMKMs That Just Can't Be Compared ;)"
};

var items = [
  CategoryInfo("All", explanation["All"]!,
      catCol["All"]![0], catCol["All"]![1]),
  CategoryInfo("Food and Beverages", explanation["Food and Beverages"]!,
      catCol["Food and Beverages"]![0], catCol["Food and Beverages"]![1]),
  CategoryInfo("Fashion", explanation["Fashion"]!,
      catCol["Fashion"]![0], catCol["Fashion"]![1]),
  CategoryInfo("Agriculture", explanation["Agriculture"]!,
      catCol["Agriculture"]![0], catCol["Agriculture"]![1]),
  CategoryInfo("Electronic", explanation["Electronic"]!,
      catCol["Electronic"]![0], catCol["Electronic"]![1]),
  CategoryInfo("Furniture", explanation["Furniture"]!,
      catCol["Furniture"]![0], catCol["Furniture"]![1]),
  CategoryInfo("Service", explanation["Service"]!,
      catCol["Service"]![0], catCol["Service"]![1]),
  CategoryInfo("Other", explanation["Other"]!,
      catCol["Other"]![0], catCol["Other"]![1])
];

class CategoryInfo {
  CategoryInfo(
      this.category,
      this.explanation,
      this.startColor,
      this.endColor,
      );

  final String category;
  final String explanation;
  final Color startColor;
  final Color endColor;
}

class CustomCardShapePainter extends CustomPainter {
  CustomCardShapePainter(
      this.radius,
      this.startColor,
      this.endColor,
      );

  final double radius;
  final Color startColor;
  final Color endColor;

  @override void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0,0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]
    );

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}