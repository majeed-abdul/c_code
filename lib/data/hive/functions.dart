import 'package:hive/hive.dart';
import 'package:qr_maze/data/hive/model.dart';

final Box<ScannedData> qrCodeBox = Hive.box<ScannedData>('scannedCodes');

void saveQRCode(ScannedData qrCode) {
  qrCodeBox.add(qrCode);
}

List<ScannedData> getAllQRCodes() {
  return qrCodeBox.values.toList();
}

Future<void> clearAllQRCodeHistory() async {
  await qrCodeBox.clear();
}

Future<void> delete(int index) async {
  await qrCodeBox.deleteAt(index);
}
