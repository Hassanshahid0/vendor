// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:url_strategy/url_strategy.dart';
import 'package:vendor_app/model/user.dart';
import 'package:vendor_app/pages/bank_page.dart';
import 'package:vendor_app/pages/bottom_nav.dart';
import 'package:vendor_app/pages/chat_list_page.dart';
import 'package:vendor_app/pages/delivery_address_page.dart';
import 'package:vendor_app/pages/flash_sales_page.dart';
import 'package:vendor_app/pages/forgot_passowrd_page.dart';
// import 'package:vendor_app/Pages/hot_deals_page.dart';
import 'package:vendor_app/pages/inbox_page.dart';
import 'package:vendor_app/pages/onboarding_page.dart';
import 'package:vendor_app/pages/policy_page.dart';
import 'package:vendor_app/pages/profile_page.dart';
import 'package:vendor_app/pages/terms_page.dart';
import 'package:vendor_app/pages/track_order_page.dart';
import 'package:vendor_app/pages/wallet_page.dart';
import 'package:vendor_app/providers/auth.dart';
import 'package:vendor_app/widgets/scaffold_widget.dart';
// import 'package:vendor_app/widgets/scaffold_widget.dart';
import 'package:vendor_app/firebase_options.dart';
import 'constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide StreamProvider;
import 'pages/about_page.dart';
// import 'Pages/home_page.dart';
import 'pages/faq_page.dart';
import 'pages/login_page.dart';
import 'pages/order_detail_page.dart';
import 'pages/orders_page.dart';
import 'pages/product_details_page.dart';
import 'pages/signup_page.dart';
import 'pages/track_order_detail_page.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
int? initScreen;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void requestFCMPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

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
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
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
bool isLogged = false;
getAuth() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      isLogged = false;

      print('Your login status is:$isLogged');
    } else {
      isLogged = true;

      print('Your login status is:$isLogged');
    }
  });
}
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences.getInstance().then((prefs) {
    initScreen = prefs.getInt("initScreen");
    prefs.setInt("initScreen", 1);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  requestFCMPermission();
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  _determinePosition();
  // await dotenv.load(fileName: ".env");
  // Stripe.publishableKey = dotenv.env['StripePublishableKey']!;
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  // usePathUrlStrategy();
  setPathUrlStrategy();
  if (kIsWeb) {
    MetaSEO().config();
  }
  await EasyLocalization.ensureInitialized();
  // requestPermission();
  getAuth();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(
    child: MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(
            value: AuthService().user,
            initialData: UserModel(
              displayName: '',
              email: '',
              phonenumber: '',
              token: '',
              uid: '',
            ),
          ),
        ],
        child: EasyLocalization(
            supportedLocales: const [
              Locale('es', 'ES'),
              Locale('en', 'US'),
              Locale('pt', 'PT')
            ],
            path: 'assets/languagesFile',
            fallbackLocale: const Locale('en', 'US'),
            child: MyApp(
              savedThemeMode: savedThemeMode,
            ))),
  ));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _retrieveToken() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String? token = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(user.uid)
          .update({'tokenID': token});
      print("My tokenID is $token");
    }
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    _retrieveToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Add MetaSEO just into Web platform condition
    if (kIsWeb) {
      // Define MetaSEO object
      MetaSEO meta = MetaSEO();
      // add meta seo data for web app as you want
      meta.author(author: 'Oliver Precious Chukwuemeka');
      meta.description(description: 'Olivette store');
      meta.keywords(keywords: 'Flutter, Dart, SEO, Meta, Web, olivette store');
    }
    return AdaptiveTheme(
        light: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik'),
        dark: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik'),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return GlobalLoaderOverlay(
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return Center(
                child: SpinKitCubeGrid(
                  color: appColor,
                  size: 50.0,
                ),
              );
            },
            child: ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (_, child) {
                  return MaterialApp.router(
                    routerConfig: router,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'Olivette Ecommerce | Online Shopping',
                    theme: theme,
                    darkTheme: darkTheme,
                  );
                }),
          );
        });
  }

  final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation:
          initScreen == 0 || initScreen == null ? '/onboarding' : '/',
      routes: [
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
          // redirect: (context, state) {
          //   if (isLogged == false) {
          //     return '/login';
          //   } else {
          //     return '/';
          //   }
          // }
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (BuildContext context, GoRouterState state) =>
              const OnBoardingPage(),
        ),
        GoRoute(
            path: '/track-order',
            builder: (BuildContext context, GoRouterState state) =>
                const TrackOrderPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/track-order';
              }
            }),
        GoRoute(
          path: '/tracking-detail/:orderID',
          builder: (BuildContext context, GoRouterState state) =>
              TrackOrderDetailPage(orderID: state.pathParameters['orderID']!),
          // redirect: (context, state) {
          //   if (isLogged == false) {
          //     return '/login';
          //   } else {
          //     return '/tracking-detail/:orderID';
          //   }
          // }
        ),
        GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) =>
              const SignupPage(),
          // redirect: (context, state) {
          //   if (isLogged == false) {
          //     return '/signup';
          //   } else {
          //     return '/';
          //   }
          // }
        ),

        GoRoute(
          path: '/terms',
          builder: (BuildContext context, GoRouterState state) =>
              const TermsPage(),
        ),
        GoRoute(
          path: '/policy',
          builder: (BuildContext context, GoRouterState state) =>
              const PolicyPage(),
        ),
        GoRoute(
            path: '/wallet',
            builder: (BuildContext context, GoRouterState state) =>
                const WalletPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/wallet';
              }
            }),
        GoRoute(
            path: '/bank',
            builder: (BuildContext context, GoRouterState state) =>
                const BankPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/bank';
              }
            }),
        GoRoute(
            path: '/profile',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfilePage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/profile';
              }
            }),

        GoRoute(
            path: '/orders',
            builder: (BuildContext context, GoRouterState state) =>
                const OrdersPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/orders';
              }
            }),

        GoRoute(
            path: '/delivery-addresses',
            builder: (BuildContext context, GoRouterState state) =>
                const DeliveryAddressPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/delivery-addresses';
              }
            }),
        GoRoute(
            path: '/inbox',
            builder: (BuildContext context, GoRouterState state) =>
                const InboxPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/inbox';
              }
            }),
        GoRoute(
          path: '/about',
          builder: (BuildContext context, GoRouterState state) =>
              const AboutPage(),
        ),
        // GoRoute(
        //   path: '/terms',
        //   builder: (BuildContext context, GoRouterState state) =>
        //       const TermsPage(),
        // ),
        GoRoute(
          path: '/faq',
          builder: (BuildContext context, GoRouterState state) =>
              const FaqPage(),
        ),
        GoRoute(
          path: '/chats',
          builder: (BuildContext context, GoRouterState state) =>
              const ChatListPage(),
        ),
        // GoRoute(
        //   path: '/policy',
        //   builder: (BuildContext context, GoRouterState state) =>
        //       const PolicyPage(),
        // ),
        GoRoute(
          path: '/order-detail/:id',
          builder: (BuildContext context, GoRouterState state) =>
              OderDetailPage(
            uid: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return ScaffoldWidget(
                path: state.path!,
                body: const BottomNavPage(),
              );
            },
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/';
              }
            }),

        GoRoute(
          path: '/product-detail/:id',
          builder: (BuildContext context, GoRouterState state) =>
              ScaffoldWidget(
            path: state.path!,
            body: ProductDetailPage(
              productUID: state.pathParameters['id']!,
            ),
          ),
        ),

        GoRoute(
          path: '/flash-sales',
          builder: (BuildContext context, GoRouterState state) =>
              ScaffoldWidget(path: state.path!, body: const FlashSalesPage()),
        ),

        // ShellRoute(
        //   navigatorKey: _shellNavigatorKey,
        //   builder: (_, GoRouterState state, child) {
        //     return ScaffoldWidget(
        //       body: child,
        //       path: state.fullPath.toString(),
        //     );
        //   },
        //   routes: [

        //   ],
        // ),
      ]);
}
