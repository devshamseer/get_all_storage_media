# Get phone Storage media globel filter 📱

## get flutteer phone storage data🔥
| S | H | A | M | S | E | E | R |
|-|-|-|-|-|-|-|-|

   <img src="https://devshamseer.github.io/Get-phone-storage-data/Screenshot_1674384360.png" alt="Logo" width="400" height="900"> 
   
   


# Import🔥

  ```sh
<uses-permission android:name="android.permission.READ_INTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACTION_MANAGE_WRITE_SETTINGS" />
   ```

  ```sh
 <application
 
  android:requestLegacyExternalStorage="true"
   ```


1. Add dependency
  ```sh
dependencies:
  permission_handler: ^10.2.0
  ```
  2. import package

  ```sh
import 'package:permission_handler/permission_handler.dart';
   ```
   
4. add media class fore github and call 

  ```sh
var images=await StoragePath.imagesPath;

 print(images[index]);
   ```
   
 # media class
 
 
  ```sh
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

   ```
 
   
