import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sme_fin/src/core/core.dart';

class ImageCompressor {
  static Future<File?> compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70,
        minWidth: 1024,
        minHeight: 1024,
        format: CompressFormat.jpeg,  // all device friendly
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      SnackBarService.showError('Error compressing image: $e');
      return null;
    }
  }
}
