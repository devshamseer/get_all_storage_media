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
   
   
   # dwonload mulifiles & ytVideos
   
   
   ```sh
   import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadFile {
  List downloadFileUrl;
  bool? customEnabelPath;

  var customDirPath;
  var fileExtension;
  var fileName;
  bool? openDownloadFile;

  bool? showSnackBar;
  bool? showDownloadProgressBarDialog;

  bool? mulipleFileDownload;
  ValueNotifier progressCount = ValueNotifier(0.0);
  ValueNotifier progresspersteage = ValueNotifier('');
  ValueNotifier downloadSignel = ValueNotifier('Downloading...');

  // download proetis
  // var downloadUrl = 'http://livre21.com/LIVREF/F6/F006145.pdf';
  // var cuPaath = '/storage/emulated/0/Download/';
  var progressString;
  var setPath;

  var filesInfo = [];

  downloadFile(BuildContext context) async {
    if (mulipleFileDownload == true) {
      // var i;
      // for (i = 0; i < downloadFileUrl.length; i++) {
      //   print(i);

      // }
      for (var i = 0; i < downloadFileUrl.length; i++) {
        if (downloadFileUrl == null ||
            downloadFileUrl == "" ||
            fileExtension == null ||
            fileExtension == "" ||
            fileName == "" ||
            fileName == null) {
          print(
              '\x1B[31m ---------------------------------------------------------------------- \x1B[0m');
          print('\n');
          print('\x1B[31m🛑 Check Your Configuration  \x1B[0m');
          print('\x1B[33m⬇️ Download File:= $downloadFileUrl  \x1B[0m');
          print('\x1B[33m📂 File Extension:=  $fileExtension  \x1B[0m');
          print('\x1B[33m📁 File Name:= $fileName  \x1B[0m');
          Flushbar(
            // mainButton: GestureDetector(
            //   onTap: () {
            //     OpenAppFile.open(setPath);
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(right: 9),
            //     height: 30,
            //     width: 70,
            //     decoration: const BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'open',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            shouldIconPulse: true,
            leftBarIndicatorColor: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            margin: const EdgeInsets.all(5),
            flushbarPosition: FlushbarPosition.TOP,
            title: 'Erorr',
            messageText: Text(
              'Please check  permissions and other setups',
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 4),
          )..show(context);
        } else {
          final status = await Permission.storage.status;
          if (status.isDenied) {
            final result = await Permission.storage.request();
            if (result != PermissionStatus.granted) {
              throw Exception('Storage permission not granted');
            }
          }

          final statust = await Permission.storage.status;
          if (statust == PermissionStatus.granted) {
            // access the directory
            final tempDir;

            if (customEnabelPath == true) {
              tempDir = await Directory('/storage/emulated/0/${customDirPath}');
            } else {
              tempDir = await Directory('/storage/emulated/0/Download/');
            }
            setPath =
                '${tempDir.path}${fileName.toString().trim()}${Random().nextInt(1000)}.${fileExtension}';
            showDownloadProgress(context, progressString);
            await Dio().download(
              downloadFileUrl[i],
              setPath,
              onReceiveProgress: (count, total) {
                progressString =
                    ((count / total) * 100).toStringAsFixed(0) + "%";
                print('\x1B[32m$progressString\x1B[0m');
                progresspersteage.value = progressString;
                progressString = progressString.toString().replaceAll('%', '');
                progressString = double.parse(progressString);
                progressCount.value = progressString;
                progressCount.notifyListeners();
              },
            );

            print('\x1B[33m File: ${setPath} \u001b[34;1m');

            final file = File(setPath);
            bool? f_exit;
            var fileSize;
            var createdDate;
            file.exists().then((value) {
              // print('File exists: ${value}');
              f_exit = value;
            });

            file.lastModified().then((value) {
              print('Last modified: ${value}');
              createdDate = value;
            });

            file.length().then((value) {
              // print(value);
              // print('File size:  ${value}');
              print(formatBytes(value));
              fileSize = formatBytes(value);

              //  file.open().then((valued) {
              //   print(valued.);
              //  });
              // print(await 'Last modified: ${file.lastModified().then((value) => value)}');

              // print('File path: ${file.path}');

              var setFileInfo = {
                "FileExists": f_exit,
                "CreatedDate": createdDate,
                "FileSize": fileSize,
                "FilePath": setPath,
              };

              filesInfo!.add(setFileInfo);

              print('\x1B[33m File: ${filesInfo} \u001b[34;1m');

              // final lengthInBytes = file.lengthSync();

              // final lengthInKB = lengthInBytes / 1024;
              // final lengthInMB = lengthInBytes / (1024 * 1024);
              // final lengthInGB = lengthInBytes / (1024 * 1024 * 1024);

              // print('File size: ${lengthInBytes} bytes');
              // print('File size: ${lengthInKB.toStringAsFixed(2)} KB');
              // print('File size: ${lengthInMB.toStringAsFixed(2)} MB');
              // print('File size: ${lengthInGB.toStringAsFixed(2)} GB');
            });

            if (showSnackBar == true) {
              Flushbar(
                icon: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                mainButton: GestureDetector(
                  onTap: () {
                    OpenAppFile.open(setPath);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 9),
                    height: 30,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        'open',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                shouldIconPulse: true,
                leftBarIndicatorColor: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                margin: const EdgeInsets.all(5),
                flushbarPosition: FlushbarPosition.TOP,
                title: 'Downloaded 🔥',
                messageText: Text(
                  'DownloadSuccessfully!',
                  style: const TextStyle(color: Colors.white),
                ),
                duration: const Duration(seconds: 4),
              )..show(context);
            }

            if (openDownloadFile == true) {
              OpenAppFile.open(setPath);
            } else {}

            try {} catch (e) {
              try {} on FileSystemException catch (e) {
                print("Error: $e");
              }
            }
          }
        }
      }
      print(downloadFileUrl.length);
    } else {
      if (downloadFileUrl == null ||
          downloadFileUrl == "" ||
          fileExtension == null ||
          fileExtension == "" ||
          fileName == "" ||
          fileName == null) {
        print('\x1B[31m🛑 Check Your Configuration \x1B[0m');
        print('\x1B[33m⬇️ Download File:= $downloadFileUrl  \x1B[0m');
        print('\x1B[33m📂 File Extension:=  $fileExtension  \x1B[0m');
        print('\x1B[33m📁 File Name:= $fileName  \x1B[0m');
        Flushbar(
          // mainButton: GestureDetector(
          //   onTap: () {
          //     OpenAppFile.open(setPath);
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.only(right: 9),
          //     height: 30,
          //     width: 70,
          //     decoration: const BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.all(Radius.circular(5)),
          //     ),
          //     child: Center(
          //       child: Text(
          //         'open',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          shouldIconPulse: true,
          leftBarIndicatorColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          margin: const EdgeInsets.all(5),
          flushbarPosition: FlushbarPosition.TOP,
          title: 'Erorr',
          messageText: Text(
            'lease check  permissions and other setups',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
        )..show(context);

        Flushbar(
          // mainButton: GestureDetector(
          //   onTap: () {
          //     OpenAppFile.open(setPath);
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.only(right: 9),
          //     height: 30,
          //     width: 70,
          //     decoration: const BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.all(Radius.circular(5)),
          //     ),
          //     child: Center(
          //       child: Text(
          //         'open',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          shouldIconPulse: true,
          leftBarIndicatorColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          margin: const EdgeInsets.all(5),
          flushbarPosition: FlushbarPosition.TOP,
          title: 'Erorr',
          messageText: Text(
            'lease check  permissions and other setups',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
        )..show(context);

        final statust = await Permission.storage.status;
        if (statust == PermissionStatus.granted) {
          // access the directory
          final tempDir;

          if (customEnabelPath == true) {
            tempDir = await Directory('/storage/emulated/0/${customDirPath}');
          } else {
            tempDir = await Directory('/storage/emulated/0/Download/');
          }
          setPath =
              '${tempDir.path}${fileName.toString().trim()}${Random().nextInt(1000)}.${fileExtension}';
          showDownloadProgress(context, progressString);
          await Dio().download(
            downloadFileUrl[0],
            setPath,
            onReceiveProgress: (count, total) {
              progressString = ((count / total) * 100).toStringAsFixed(0) + "%";
              print('\x1B[32m$progressString\x1B[0m');
              progresspersteage.value = progressString;
              progressString = progressString.toString().replaceAll('%', '');
              progressString = double.parse(progressString);
              progressCount.value = progressString;
              progressCount.notifyListeners();
            },
          );

          print('\x1B[33m File: ${setPath} \u001b[34;1m');

          if (showSnackBar == true) {
            Flushbar(
              mainButton: GestureDetector(
                onTap: () {
                  OpenAppFile.open(setPath);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 9),
                  height: 30,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      'open',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              shouldIconPulse: true,
              leftBarIndicatorColor: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              margin: const EdgeInsets.all(5),
              flushbarPosition: FlushbarPosition.TOP,
              title: 'Downloaded 🔥',
              messageText: Text(
                'DownloadSuccessfully!',
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 4),
            )..show(context);
          }

          if (openDownloadFile == true) {
            OpenAppFile.open(setPath);
          } else {}

          try {} catch (e) {
            try {} on FileSystemException catch (e) {
              print("Error: $e");
            }
          }
        }
      }
    }

    return filesInfo;
  }

  showDownloadProgress(BuildContext contex, progressString) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //  Container(height: 100,width: 100,color: Colors.amber,);
      if (showDownloadProgressBarDialog == true) {
        if (progressCount.value == '100%') {
          Navigator.pop(contex);
          print('Ffffff');
        } else {
          showDialog(
              context: contex,
              builder: (_) {
                return AlertDialog(
                  title: ValueListenableBuilder(
                    valueListenable: progresspersteage,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value == '100%' ? 'Completed' : 'Downloading...',
                          ),
                          Text(
                            value.toString(),
                          ),
                        ],
                      );
                    },
                  ),
                  content: ValueListenableBuilder(
                    valueListenable: progressCount,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      if (value == toString()) {
                        value = value.toString().replaceAll('%', '');
                        value = double.parse(value);
                      } else {
                        value = value.toString().replaceAll('%', '');
                        value = double.parse(value);
                      }
                      value = value.toString().replaceAll('%', '');
                      value = double.parse(value);
                      if (value == 100) {
                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.pop(context);
                        });
                      }

                      return SizedBox(
                        width: 250,
                        child: value == 100
                            ? GestureDetector(
                                onTap: () {
                                  OpenAppFile.open(setPath);
                                },
                                child: Container(
                                  // margin: const EdgeInsets.only(right: 12),
                                  height: 40,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'OPEN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : FAProgressBar(
                                // verticalDirection: VerticalDirection.up,
                                backgroundColor:
                                    Color.fromARGB(255, 231, 232, 234),
                                progressColor: Color.fromARGB(255, 9, 38, 82),
                                currentValue: value,
                                displayText: ' %',
                                displayTextStyle: TextStyle(
                                    color: Color.fromARGB(0, 255, 255, 255)),
                              ),
                      );
                    },
                  ),
                );
              });
        }
      }
    });
  }

  downloadYoutubeVideos(BuildContext context) async {
    if (downloadFileUrl == null ||
        downloadFileUrl.isEmpty == true ||
        downloadFileUrl == "" ||
        downloadFileUrl.length == 0) {
      print('\x1B[31m🛑 Check Your Configuration \x1B[0m');
      Flushbar(
        icon: Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        leftBarIndicatorColor: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        margin: const EdgeInsets.all(5),
        flushbarPosition: FlushbarPosition.TOP,
        title: 'Erorr',
        messageText: Text(
          'Add youtube links',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 4),
      )..show(context);
    } else {
      // for (var i = 0; i < downloadFileUrl.length; i++) {
      //   print(await 'Downloding Start${i + 1}');
      //   await Future.delayed(Duration(seconds: 3), () async {
      //     await downloadYoutubeVideosController(
      //         downloadFileUrl[i], customDirPath, context);
      //   });

      //   print(await 'End');
      // }

      final status = await Permission.storage.status;
      if (status.isDenied) {
        final result = await Permission.storage.request();
        if (result != PermissionStatus.granted) {
          throw Exception('Storage permission not granted');
        }
      }

      final statust = await Permission.storage.status;
      if (statust == PermissionStatus.granted) {
        // access the directory

        try {
          for (var i = 0; i < downloadFileUrl.length; i++) {
            print(await '\x1B[35m Downloading Started ⬇️ \x1B[0m');
            await Future.delayed(Duration(seconds: 3), () async {
              await downloadYoutubeVideosController(
                  downloadFileUrl[i], customDirPath, context);
            });

            print(await '\x1B[32m Download Finished ✅\x1B[0m');
          }
        } on FileSystemException catch (e) {
          print("Error: $e");
        }
      } else {
        // display an error message or request the permission again
      }
    }
  }

  DownloadFile({
    required this.downloadFileUrl,
    required this.fileName,
    required this.fileExtension,
    this.customEnabelPath,
    this.customDirPath,
    this.openDownloadFile,
    this.showSnackBar = true,
    this.showDownloadProgressBarDialog,
    this.mulipleFileDownload,
  });

  String formatBytes(int bytes) {
    if (bytes < 1024) {
      return '${bytes} bytes';
    } else if (bytes < 1024 * 1024) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      final mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(2)} MB';
    } else {
      final gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(2)} GB';
    }
  }
}
// YoutubeVidoe
// Youtube Video Download

downloadYoutubeVideosController(
    youtubeVideoLink, downloadFolder, BuildContext context) async {
  var yt = YoutubeExplode();

  //  'https://www.youtube.com/watch?v=Os9TlUlCkX0&list=RDOs9TlUlCkX0&index=1'
  var videoGet = await yt.videos.get(youtubeVideoLink);

  var fileName = videoGet.title.trim();

  var manifest = await yt.videos.streamsClient.getManifest(videoGet.id);
  var streamInfo = manifest.muxed.withHighestBitrate();

  if (streamInfo != null) {
    // Get the actual stream
    var stream = yt.videos.streamsClient.get(streamInfo);

    // Open a file for writing.
    File file;
    if (downloadFolder == null || downloadFolder == "") {
      file = File(
          '/storage/emulated/0/Download/MokzVideoDwonloder🔥${fileName}(${Random().nextInt(1000)}).mp4');
    } else {
      Directory folder = await Directory('/storage/emulated/0/$downloadFolder');
      folder.createSync(recursive: true);
      // print(folder);
      print('\x1B[32m Created Folder 📁:= $folder  \x1B[0m');

      file = File(
          '/storage/emulated/0/${downloadFolder}/${fileName}(${Random().nextInt(1000)}).mp4');
    }
    var fileStream = file.openWrite();
    // Pipe all the content of the stream into the file.
    await stream.pipe(fileStream);
    // download progress
  // const chunkSize = 1024 * 1024; // 1 MB chunks
  // var totalBytes = 0;
  // var bytesWritten = 0;
  //   final data = List.filled(chunkSize, 'x').join();
  // while (bytesWritten < 100 * chunkSize) {
  //   // fileStream.write(data);
  //   bytesWritten += chunkSize;
  //   totalBytes = await file.length(); // Get the current file size
  //   await fileStream.flush(); // Flush the buffer to the file
  //   final percent = (bytesWritten / (100 * chunkSize) * 100).toStringAsFixed(2);
  //   print('Written $bytesWritten bytes of ${100 * chunkSize} bytes ($percent%)');
  // }





    var data1 = await fileStream.done;
    data1 = data1.toString().replaceAll('File: ', '');
    data1 = data1.toString().replaceAll('\'', '');
    print(data1);
    var data2 = file.toString();
    data2 = data2.toString().replaceAll('File: ', '');
    data2 = data2.toString().replaceAll('\'', '');
    print('🛑');
    print(data2);
    if (data1 == data2) {
      Flushbar(
        icon: Container(
          margin: EdgeInsets.only(left: 15),
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.white,
          ),
        ),
        mainButton: GestureDetector(
          onTap: () {
            OpenAppFile.open(data1);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 9),
            height: 30,
            width: 70,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                'open',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        shouldIconPulse: true,
        leftBarIndicatorColor: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        margin: const EdgeInsets.all(5),
        flushbarPosition: FlushbarPosition.TOP,
        title: 'Downloaded 🔥',
        messageText: Text(
          'DownloadSuccessfully!',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 4),
      )..show(context);
    } else {
      Flushbar(
        icon: Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        leftBarIndicatorColor: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        margin: const EdgeInsets.all(5),
        flushbarPosition: FlushbarPosition.TOP,
        title: 'Erorr',
        messageText: Text(
          'Download erro 😢',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 4),
      )..show(context);
    }

    // print(await fileStream.done);

    // Close the file.
    // await fileStream.flush();
    await fileStream.close();
    yt.close();
  }
}

   
   
   ```
 
   
