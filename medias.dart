import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class StoragePath {
  static const MethodChannel _channel = const MethodChannel('storage_path');

  /// To load images path on device
  static Future get imagesPath async {
  var data = await _channel.invokeMethod('getImagesPath');
   var decoded=jsonDecode(data!);
    return decoded;
  }

  /// To load video path on device
  static Future get videoPath async {
 var data = await _channel.invokeMethod('getVideosPath');
   var decoded=jsonDecode(data!);
    return decoded;
  }

  /// To load audio path on device
  static Future get audioPath async {
 var data = await _channel.invokeMethod('getAudioPath');
  var decoded=jsonDecode(data!);
    return decoded;
  }

  /// To load file path on device
  static Future<String?> get filePath async {
 var data = await _channel.invokeMethod('getFilesPath');
   var decoded=jsonDecode(data!);
    return decoded;
  }
}
