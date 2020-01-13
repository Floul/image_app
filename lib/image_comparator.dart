import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageComparator {
  static Future<Image> compareImages(
      String firstImagePath, String secondImagePath) async {
    img.Image _firstImage = await getBitmap(firstImagePath);
    img.Image _secondImage = await getBitmap(secondImagePath);
    img.Image _differenceImage = img.Image.from(_secondImage);
    if (_firstImage.width != _secondImage.width ||
        _firstImage.height != _secondImage.height) {
      throw Exception("Images must have the same dimensions!");
    }
    for (int x = 0; x < _firstImage.width; x++) {
      for (int y = 0; y < _firstImage.height; y++) {
        if (_firstImage.getPixelSafe(x, y) != _secondImage.getPixelSafe(x, y)) {
          _differenceImage.setPixel(x, y, 0xFFFFA500);
        }
      }
    }
    return Image.memory(img.encodePng(_differenceImage));
  }

  static Future<img.Image> getBitmap(String assetPath) async {
    ByteData firstImageBytes = await rootBundle.load(assetPath);
    List<int> values = firstImageBytes.buffer.asUint8List();
    return img.decodeImage(values);
  }
}
