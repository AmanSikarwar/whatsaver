class ImageStatus {
  String imagePath;
  String imageName;
  int imageSize;
  DateTime lastModified;

  ImageStatus({
    required this.imagePath,
    required this.imageName,
    required this.imageSize,
    required this.lastModified,
  });
}
