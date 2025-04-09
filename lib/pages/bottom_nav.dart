import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vendor_app/pages/flash_sales_page.dart';
import 'package:vendor_app/pages/hot_deals_page.dart';
import 'package:vendor_app/pages/orders_page.dart';
import 'package:vendor_app/pages/products.dart';
import '../model/categories.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;
  List<CategoriesModel> allCats = [];
  bool isLoading = false;

  // Define your screens here

  navToHotDeal() {
    setState(() {
      currentIndex = 1;
    });
  }

  navToFlashSales() {
    setState(() {
      currentIndex = 2;
    });
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
    requestFCMPermission();
    // await dotenv.load(fileName: ".env");
    if (!kIsWeb) {
      setupFlutterNotifications();
    }
    super.initState();
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await setupFlutterNotifications();
    showFlutterNotification(message);
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    // ignore: avoid_print
    print('Handling a background message ${message.messageId}');
  }

  void requestFCMPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // ignore: avoid_print
    print('FCM Permission status: ${settings.authorizationStatus}');
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

// void _retrieveToken() async {
//   String? token = await FirebaseMessaging.instance.getToken();
//   print('FCM Token: $token');
// }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    return FlutterCloseAppPage(
      interval: 2,
      condition: true,
      onCloseFailed: () {
        // The interval is more than 2 seconds, or the return key is pressed for the first time
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Press again to exit'),
        ));
      },
      child: Scaffold(
        body: currentIndex == 0
            ? const OrdersPage(
                // navToHotDeal: navToHotDeal,
                // navToFlashSales: navToFlashSales,
                )
            : currentIndex == 1
                ? const ProductsPage()
                : currentIndex == 3
                    ? const HotSalesPage()
                    : currentIndex == 2
                        ? const FlashSalesPage()
                        : null,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Orders'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_bag),
              label: 'Products'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.date_range),
              label: 'Flash Sales'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.today),
              label: 'profiles'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
