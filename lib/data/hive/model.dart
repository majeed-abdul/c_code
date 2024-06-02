import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class ScannedData {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String data;

  @HiveField(3)
  final DateTime dateTime;

  ScannedData({
    required this.type,
    required this.title,
    required this.data,
    required this.dateTime,
  });
}
