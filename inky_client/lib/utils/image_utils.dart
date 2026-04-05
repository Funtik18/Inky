  String resolveImageContentType(String fileName) {
    final lowerCaseName = fileName.toLowerCase();

    if (lowerCaseName.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerCaseName.endsWith('.webp')) {
      return 'image/webp';
    }

    return 'image/jpeg';
  }