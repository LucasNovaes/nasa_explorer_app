import 'dart:io';

Future<bool> checkConnectivity({bool forceOffline = false}) async {
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (!forceOffline &&
        result.isNotEmpty &&
        result.first.rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } catch (_) {
    return false;
  }
}
