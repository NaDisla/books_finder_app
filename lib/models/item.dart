import 'models.dart';

class Item {
  VolumeInfo volumeInfo;
  String id;
  Item({required this.volumeInfo, required this.id});

  factory Item.fromApiItems(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      volumeInfo: VolumeInfo.fromApiJson(json['volumeInfo']),
    );
  }
}
