import 'package:string_validator/string_validator.dart';

bool isWebURL(String text) {
  if (isGeo(text)) {
    return false;
  } else if (isEmail(text)) {
    return false;
  }
  try {
    return isURL(text);
    // return Uri.tryParse(widget.result.code ?? '')?.isAbsolute ?? false;
  } catch (e) {
    return false;
  }
}

bool isWiFi(String text) {
  bool validURL = text.toUpperCase().startsWith('WIFI:') && text.endsWith(';');
  return validURL;
}

bool isGeo(String text) {
  String res = text.toUpperCase();
  bool validGeo =
      res.startsWith('GEO:') || res.contains('MAPS.GOOGLE.COM/LOCAL?Q=');
  return validGeo;
}

bool isPhone(String text) {
  bool validPhone = text.toUpperCase().startsWith('TEL:');
  return validPhone;
}

bool isVCard(String text) {
  bool validURL = text.toUpperCase().startsWith('BEGIN:VCARD') &&
      text.trim().toUpperCase().endsWith('END:VCARD'); //need testing
  return validURL;
}

bool isEmail(String text) {
  bool validURL = text.toUpperCase().startsWith(
            "MATMSG:TO:",
          ) ||
      text.toUpperCase().startsWith(
            "MAILTO:",
          );
  return validURL;
}

bool isSMS(String text) {
  bool validURL = text.toUpperCase().startsWith("SMSTO:");
  return validURL;
}

bool isNum(String text) {
  try {
    double.parse(text);
  } on FormatException {
    if (text.isEmpty) return true;
    return false;
  }
  return true;
}

String resultType(String res) {
  return isWebURL(res)
      ? 'URL'
      : isNum(res)
          ? 'Number'
          : isVCard(res)
              ? 'Contact'
              : isGeo(res)
                  ? 'Geo Location'
                  : isEmail(res)
                      ? 'Email'
                      : isSMS(res)
                          ? 'Message'
                          : isWiFi(res)
                              ? 'WiFi'
                              : isPhone(res)
                                  ? 'Phone'
                                  : 'Text';
}
