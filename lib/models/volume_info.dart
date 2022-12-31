import 'models.dart';

class VolumeInfo {
  String title;
  List<String> authors;
  String publishedDate;
  String description;
  ImageLinks? imageLinks;

  VolumeInfo(
      {required this.title,
      required this.authors,
      required this.publishedDate,
      required this.description,
      required this.imageLinks});

  factory VolumeInfo.fromApiJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title']!,
      authors: json['authors'] == null
          ? []
          : List<String>.from(json['authors'].map((x) => x)),
      publishedDate: json['publishedDate'] ?? '',
      description: json['description'] ?? '',
      imageLinks: ImageLinks.fromApiJson(json['imageLinks'] ??
          {
            'thumbnail':
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
          }),
    );
  }
}
