import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageComparator {
  static Future<Image> compareImages(
      String firstImagePath, String secondImagePath) async {
    img.Image firstImage = await getBitmap(firstImagePath);
    img.Image secondImage = await getBitmap(secondImagePath);
    img.Image differenceImage = img.Image.from(secondImage);
    if (firstImage.width != secondImage.width ||
        firstImage.height != secondImage.height) {
      throw Exception("Images must have the same dimensions!");
    }
    for (int x = 0; x < firstImage.width; x++) {
      for (int y = 0; y < firstImage.height; y++) {
        if (firstImage.getPixelSafe(x, y) != secondImage.getPixelSafe(x, y)) {
          differenceImage.setPixel(x, y, 0xFFFFA500);
        }
      }
    }
    return Image.memory(img.encodePng(differenceImage));
  }

  static Future<img.Image> getBitmap(String assetPath) async {
    ByteData firstImageBytes = await rootBundle.load(assetPath);
    List<int> values = firstImageBytes.buffer.asUint8List();
    return img.decodeImage(values);
  }
}
