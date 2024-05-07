import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class UploadImage {
  static Future<List<String>> multi() async {
    List<String> path = [];

    try {
      final ImagePicker pickedImage = ImagePicker();
      List<XFile> image = await pickedImage
          .pickMultiImage()
          .onError((PlatformException error, stackTrace) async {
        await _photoPermissDenied(error);
        return [];
      });

      if (image.isNotEmpty) {
        for (var e in image) {
          var newImg = await _checkSizeImageAndCompress(e, e.name);
          if (newImg != null) {
            path.add(newImg.path);
          }
        }
      }
    } catch (e) {
      logError("Error while addMultiAssets $e");
    }

    return path;
  }

  static Future<String> single() async {
    String path = '';
    try {
      final ImagePicker pickedImage = ImagePicker();
      XFile? image = await pickedImage
          .pickImage(source: ImageSource.gallery)
          .onError((PlatformException error, stackTrace) async {
        await _photoPermissDenied(error);
        return null;
      });

      if (image != null) {
        image = await _checkSizeImageAndCompress(image, image.name);
        path = image != null ? image.path : '';
      }
    } catch (e) {
      logError("Error while addAssets $e");
    }
    return path;
  }

  static Future<XFile?> _checkSizeImageAndCompress(
      XFile image, String oldName) async {
    final bytes = (await image.readAsBytes()).lengthInBytes;

    logInfo("Image Size : ${bytes.mb}");

    if (bytes.mb <= 1) {
      logInfo('Not compressed');
      return image;
    } else {
      var newImg = await _compressImage(File(image.path), oldName, bytes.mb);
      if (newImg != null) {
        final bytes = (await newImg.readAsBytes()).lengthInBytes;
        if (bytes.mb <= 3) {
          logInfo('has been compressed ${bytes.mb}');
          return newImg;
        } else {
          // customSnackbar(
          //   allowDuplicate: true,
          //   message:
          //       "${'sorry_ur_img'} ${oldName.truncateString(15)} ${'is_too_large'}",
          //   duration: const Duration(seconds: 4),
          //   snackBarStatus: SnackBarStatus.error,
          // );
          return null;
        }
      }
    }
    return null;
  }

  static Future<void> _photoPermissDenied(PlatformException error) async {
    if (error.code == 'photo_access_denied') {
      PermissionStatus result = PermissionStatus.denied;
      if (Platform.isAndroid) {
        result = await Permission.storage.request();
        //for PO phone Only
        if (!result.isGranted) {
          result = await Permission.photos.request();
        }
      }
      if (Platform.isIOS) {
        result = await Permission.photos.request();
      }

      if (result.isPermanentlyDenied || result.isDenied) {
        await openAppSettings();
      }
    }
  }

  static Future<XFile?> _compressImage(
      File file, String name, double mb) async {
    try {
      var exten = p.extension(file.path);
      bool isGif = false;
      if (exten.contains('.gif')) {
        exten = '.jpg';
        isGif = true;
      }
      var newPath =
          "${file.path.replaceAll(isGif ? '.gif' : exten, '_compress')}$exten";
      logSuccess(newPath);
      return await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        "${file.path.replaceAll(exten, '_compress')}$exten",
        // format: p.extension(file.path).endsWith('.png')
        //     ? CompressFormat.png
        //     : CompressFormat.jpeg,
      );
    } on CompressError catch (e) {
      logError("Error  ${e.message}");
    } catch (e) {
      logError("Error compressing image $e");
    }
    return null;
  }
}
