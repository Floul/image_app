import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageComparator {
  static Future<Image> compareImages(String firstImagePath, String secondImagePath) async {
    img.Image firstImage = await getBitmap(firstImagePath);
    img.Image secondImage = await getBitmap(secondImagePath);
    img.Image differenceImage = secondImage;
    if (firstImage.width != secondImage.width ||
        firstImage.height != secondImage.height) {
      throw Exception("Images must have the same dimensions!");
    }
    for (int y = 0; y < firstImage.height; y++) {
      for (int x = 0; x < firstImage.width; x++) {
        bool isPixelEqual =
            firstImage.getPixelSafe(x, y) == secondImage.getPixelSafe(x, y);
        if (!isPixelEqual){
          int pixel = secondImage.getPixelSafe(x, y);
          differenceImage.setPixel(x, y, 0xFFFFA500);
        }
      }
    }
    return Image.memory(img.encodePng(secondImage));
  }

  static Future<img.Image> getBitmap(String assetPath) async {
    ByteData firstImageBytes = await rootBundle.load(assetPath);
    List<int> values = firstImageBytes.buffer.asUint8List();
    return img.decodeImage(values);
  }

  static int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }
}
