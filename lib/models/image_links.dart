class ImageLinks {
  String thumbnail;

  ImageLinks({required this.thumbnail});

  factory ImageLinks.fromApiJson(Map<String, String> json) {
    return ImageLinks(thumbnail: json['thumbnail']!);
  }
}
