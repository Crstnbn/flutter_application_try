import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

Future<Uint8List> assetToBytes(String path, {int width = 100}) async {
  final byData = await rootBundle.load(path);
  final bytes = byData.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes, targetWidth: width);

  final frame = await codec.getNextFrame();
  final newByteData = await frame.image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  return newByteData!.buffer.asUint8List();
}
