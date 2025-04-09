import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:vendor_app/constant.dart';

class PushNotificationFunction {
  static Future<void> sendPushNotification(
      String title, String msg, String token) async {
    var jsonCredentials = r'''
{
  "type": "service_account",
  "project_id": "ecommerce-multivendor-cd06c",
  "private_key_id": "9733ab76977f99807c0be41eac543b9f9ba0e6e9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDQLIh8373Z61AU\nmg/+zhd0ic5GI27+3yO7/IfyYcWZRfHNBtJGEAa1uuEx0vAYpg/iJ+f7W63WCcNe\ns35U2KjPHG6pgnBMTnd2FwuGTAU+UnTqR/DvvpV5ZQ3ICoYcCLNf8tH4kudaBxmy\nHoP3THB/h8NYc5NJ0nMTObIQPo0zhsHEVUuG9f5N0T3uo6AkUWvEua7VS0xLhCVi\nMv5cYmSHUv5ALcL9kOtdAxLpXey4v20b8lF03um5oCQU+x2w7ps8/x2RpKRo4WLW\nMBYPdhdHsCk9T1Qy96avt+pJDaUgT9zEuoT93vpypT6/rNU/F9BQ/13U8KSD22C3\nekRqaQxZAgMBAAECggEAK/u4w7+HLo+R/iRV7FVxbbk/CKEsbrPJKksPEyZWuE1n\nqxS9oTl6HXP0aBFEEsUlVnhtgnVqm245Jd1hO/6B3i6I8A4j+W9bvKreT7vooLQN\nyUE1dgYLsVgpSwJ0NuCcu5FDjVRGhsY4xuI9KicvnrZZzuqubDrHfwCh714z+bZl\nZcD+7PVcfHiS75CPu4Zcb1j0kb2yAxCdZUAXHP1kziRqK0lRZsEEqjvBPaai0mzH\nDmhQIXnnENPpzhlnASvwe8ZZX83G/N6luTdHMzBiJfpvMJ/ApnthIl78fRasxUjA\nS+C2GcLPpivslK5DldXMgw6JC6YnyoHd2Hc288EbvQKBgQDSAJEHmvCznvuIUHLm\nMjkLdGRdqBUMSYEYJzspeGNALl9Ad0mmxsUSYmHDKVqt3o7LtDfcgeeoE+iaFVfj\nsQsS/antyVaj77XdA/JEGcj1y0OMQNAJOynmzKy5d1Dojf3VtPNU7bweY/w9YsNs\nKZBmdAnFrRq/w8Zv4lYgZdcaLQKBgQD9xXN4ErYAf3n3+BkVdcxMaFLXWt0FldXz\nYcGhtHDGCf6hM/qcgsZLHFEhD2OS17OTzvMlLnW8wVo3y7EESlBLd+xcbHnlfLso\n3ZtlAowN0mbQaO0k3nJdihrBchTafG4cCLOdJwyWdYuJBtDJ5lhJHAkE0hH2ZOoC\nboWbWF7yXQKBgFAgozXRqrH+oV77wzuOQjHasUkDDzTm/vjmTy6dntEoYHPKkDGw\nehVvsHm018KrvrR/CSl775Y0MnZIWoaoUN9oJmRyhDp9BllUXiYZ6JHQgu+K81Xy\nWySTR/xkSFzTgNz/9DCdnT/DSsVpX8NvgId3Ext311MAMkESjWZDNXXpAoGBAPu6\nDkVQQiuSR/map78q36H3Zh1ra40ryVQoZzuxUqCPr35WokT4UByXlT53Fm3F+8Ml\n6Pi78lxva7+nFQvNb4K9Db/MdsoWhU0PLiLveOAJEqWvP3VwFwAEi2/Say8jeNHk\nK886ufjR1rzw/tEX5gF3hta6Tskb5yjMW0nyShSdAoGACY/UiHu2HoTOB/cQA24c\n70xpv8rWEdjhXN9T8eD7uXSkXax0ii54dj9seJ2XCxo8ilg9BSjmxgcdLztdr1b6\nNIyiHDH0hzqwYuk/LCyPFRHV1RPyDuuawS723R8CB/PYBtt904W1X9BnARpbZ86x\nnanFkmAK+oIqVsiDNh+KWIc=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-z67nh@ecommerce-multivendor-cd06c.iam.gserviceaccount.com",
  "client_id": "115711005638255062971",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-z67nh%40ecommerce-multivendor-cd06c.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
 ''';

    var credentials = ServiceAccountCredentials.fromJson(jsonCredentials);

    // Scopes for Firebase Cloud Messaging
    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Authenticate and obtain an HTTP client
    var client = await clientViaServiceAccount(credentials, scopes);

    // FCM endpoint for HTTP v1 requests
    String url =
        'https://fcm.googleapis.com/v1/projects/$projectID/messages:send';

    // Construct the message payload
    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": msg},
        // "data": {
        //   "click_action": "FLUTTER_NOTIFICATION_CLICK",
        //   "id": "1",
        //   "status": "done"
        // }
      }
    };

    // Send the POST request
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(message),
      );
// ignore: avoid_print
      print(response.body);
      // ignore: avoid_print
      print(response.statusCode);
      if (response.statusCode == 200) {
      } else {}
      // ignore: empty_catches
    } catch (e) {}

    // Close the client
    client.close();
  }
}
