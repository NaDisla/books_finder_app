import 'models.dart';

class Item {
  VolumeInfo volumeInfo;

  Item({required this.volumeInfo});

  factory Item.fromApiItems(Map<String, dynamic> json) {
    return Item(volumeInfo: VolumeInfo.fromApiJson(json['volumeInfo']));
  }
}
