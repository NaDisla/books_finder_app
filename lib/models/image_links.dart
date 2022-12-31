class ImageLinks {
  String thumbnail;

  ImageLinks({required this.thumbnail});

  factory ImageLinks.fromApiJson(Map<String, dynamic> json) {
    return ImageLinks(thumbnail: json['thumbnail']);
  }
}
