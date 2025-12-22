import 'dart:io';
import 'package:path/path.dart';

import 'package:file_picker/file_picker.dart';
import 'package:sme_fin/src/core/services/snack_bar_service.dart';

class FilePickerService {
  static Future<PlatformFile?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        return result.files.single;
      }
    } catch (e) {
      SnackBarService.showError('Error picking file: $e');
    }
    return null;
  }

  static String? getFileName(File? file) {
    return file == null ? null : basename(file.path);
  }
}
