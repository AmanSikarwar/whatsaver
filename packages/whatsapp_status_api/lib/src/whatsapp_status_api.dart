/// {@template whatsapp_status_api}
/// API providing statuses from whatsapp on Android
/// {@endtemplate}

import 'dart:io';

import 'package:whatsapp_status_api/models/imageStatus.dart';

const whatsAppStatusDirectoryPath =
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/';
const whatsAppStatusDirectoryPath_legacy =
    '/storage/emulated/0/WhatsApp/Media/.Statuses/';

class WhatsappStatusApi {
  /// {@macro whatsapp_status_api}
  const WhatsappStatusApi();

  Directory? getStatusDirectory() {
    if (Directory(whatsAppStatusDirectoryPath).existsSync()) {
      return Directory(whatsAppStatusDirectoryPath);
    } else if (Directory(whatsAppStatusDirectoryPath_legacy).existsSync()) {
      return Directory(whatsAppStatusDirectoryPath_legacy);
    } else {
      return null;
    }
  }

  bool get isStatusDirectoryExists => getStatusDirectory() != null;

  List<ImageStatus>? getImages() {
    if (isStatusDirectoryExists) {
      final statusDirectory = getStatusDirectory();
      return statusDirectory
          ?.listSync()
          .where(
            (file) => file.path.endsWith('.jpg') || file.path.endsWith('.jpeg'),
          )
          .map<ImageStatus>((file) {
        print(file.path);
        final image = file as File;
        return ImageStatus(
          imagePath: image.path,
          imageName: image.absolute.path,
          imageSize: image.lengthSync(),
          lastModified: image.lastModifiedSync(),
        );
      }).toList();
    }
  }
}
