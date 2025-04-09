// ignore_for_file: avoid_build_context_in_providers
import 'package:riverpod/riverpod.dart';
import 'package:vendor_app/model/history.dart';
import 'package:vendor_app/model/order_model.dart';
import 'package:vendor_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendor_app/providers/push_notification.dart';
part 'order_detail_provider.g.dart';

var logger = Logger();
@riverpod
Future<UserModel> getUserDetails(Ref ref, String userUID) async {
  var doc =
      await FirebaseFirestore.instance.collection('users').doc(userUID).get();
  return UserModel.fromMap(doc.data()!, doc.id);
}

@riverpod
Future<num> getAdminCommission(Ref ref) async {
  var r =
      await FirebaseFirestore.instance.collection('Admin').doc('Admin').get();
  logger.d('Admin Commission is ${r.data()!['commission']}');
  return r.data()!['commission'];
}

@riverpod
Future<num> getWallet(Ref ref, userUID) async {
  var r =
      await FirebaseFirestore.instance.collection('users').doc(userUID).get();
  return r.data()!['wallet'];
}

@riverpod
Future<num> getRiderCharge(Ref ref) async {
  var r = await FirebaseFirestore.instance
      .collection('Rider Charge')
      .doc('Rider Charge')
      .get();
  logger.d('Rider Charge is ${r.data()!['Rider Charge']}');
  return r.data()!['Rider Charge'];
}

@riverpod
Stream<OrderModel2> fetchOrderDetail(Ref ref, String orderID) {
  return FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderID)
      .snapshots(includeMetadataChanges: true)
      .map((doc) {
    // var logger = Logger();
    // logger.d(doc.data());
    return OrderModel2(
      orders: [
        ...(doc.data()!['orders']).map((items) {
          return OrdersList.fromMap(items);
        })
      ],
      pickupStorename: doc.data()!['pickupStorename'],
      pickupPhone: doc.data()!['pickupPhone'],
      pickupAddress: doc.data()!['pickupAddress'],
      instruction: doc.data()!['instruction'],
      couponPercentage: doc.data()!['couponPercentage'],
      couponTitle: doc.data()!['couponTitle'],
      useCoupon: doc.data()!['useCoupon'],
      confirmationStatus: doc.data()!['confirmationStatus'],
      uid: doc.data()!['uid'],
      // marketID: doc.data()!['marketID'],
      vendorIDs: [
        ...(doc.data()!['vendorIDs']).map((items) {
          return items;
        })
      ],
      userID: doc.data()!['userID'],
      deliveryAddress: doc.data()!['deliveryAddress'],
      houseNumber: doc.data()!['houseNumber'],
      closesBusStop: doc.data()!['closesBusStop'],
      deliveryBoyID: doc.data()!['deliveryBoyID'],
      status: doc.data()!['status'],
      accept: doc.data()!['accept'],
      orderID: doc.data()!['orderID'],
      timeCreated: doc.data()!['timeCreated'].toDate(),
      total: doc.data()!['total'],
      deliveryFee: doc.data()!['deliveryFee'],
      acceptDelivery: doc.data()!['acceptDelivery'],
      paymentType: doc.data()!['paymentType'],
    );

    // carts.remove(id);
    // quantity = orderDetail!.orders
    //     .fold(0, (amount, product) => amount + product.quantity);
    // selectedPrice = orderDetail!.orders.fold(0,
    //     (price, product) => price + product.selectedPrice * product.quantity);
  });
  //  for (var element in orderDetail!.orders) {

  //  }
}

@riverpod
double getPercentageOfCoupon(Ref ref, OrderModel2 orderModel) {
  if (orderModel.couponPercentage != 0) {
    var result = (orderModel.total * orderModel.couponPercentage) / 100;
    return result;
  } else {
    return 0;
  }
}


history( HistoryModel historyModel, String userUID) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userUID)
      .collection('Transaction History')
      .add(historyModel.toMap());
}

historyRider(HistoryModel historyModel, String userUID) {
  FirebaseFirestore.instance
      .collection('riders')
      .doc(userUID)
      .collection('Transaction History')
      .add(historyModel.toMap());
}

historyVendor(HistoryModel historyModel, String userUID) {
  FirebaseFirestore.instance
      .collection('vendors')
      .doc(userUID)
      .collection('Transaction History')
      .add(historyModel.toMap());
}

@riverpod
updateWallet(Ref ref, OrderModel2 orderModel) {
  final getCoupon = ref.read(getPercentageOfCouponProvider(orderModel));
  final wallet = ref.watch(getWalletProvider(orderModel.userID));
  wallet.whenData((c) {
    if (orderModel.paymentType == 'Wallet') {
      var total = orderModel.total + getCoupon;
      FirebaseFirestore.instance
          .collection('users')
          .doc(orderModel.userID)
          .update({'wallet': c + total}).then((value) {
        // Get the current date and time
        // DateTime now = DateTime.now();

        // Format the date to '24th January, 2024' format
        // String formattedDate = DateFormat('d MMMM, y').format(now);
       history(
            HistoryModel(
                message: 'Debit Alert',
                amount: total.toString(),
                paymentSystem: 'Wallet',
                timeCreated: DateTime.now()),
            orderModel.userID);
        // history(HistoryModel(
        //     message: 'Debit Alert',
        //     amount: total.toString(),
        //     paymentSystem: 'Wallet',
        //     timeCreated: formattedDate));
        // Fluttertoast.showToast(
        //         msg: "Wallet has been uploaded successfully".tr(),
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.TOP,
        //         timeInSecForIosWeb: 1,
        //         fontSize: 14.0)
        //     .then((value) {
        //
        // });
      });
    }
  });
}

@riverpod
Future<void> updateStatus(Ref ref, String orderStatus, OrderModel2 orderModel,
    BuildContext context, String userToken, String notificationID) async {
  // final loading = ref.read(loadingProviderProvider.notifier);
  context.loaderOverlay.show();
  if (orderStatus == 'Confirmed') {
    // loading.setLoading(true);
    acceptedTimeCreatedFunc(orderModel.uid);
    PushNotificationFunction.sendPushNotification(
        'Order notification', 'Your order has been accepted', userToken);
  

    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderModel.uid)
        .update({'accept': true, 'status': orderStatus}).then((value) {
      // loading.setLoading(false);

      if (context.mounted) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "Status has been updated".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
      }
    });
  } else if (orderStatus == 'Cancel') {
    // acceptedTimeCreatedFunc();
    // loading.setLoading(true);
    PushNotificationFunction.sendPushNotification(
        'Order notification', 'Your order has was cancelled', userToken);
  
    ref.read(updateWalletProvider(orderModel));

    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderModel.uid)
        .update({'accept': false, 'status': 'Cancelled'}).then((value) {
      // loading.setLoading(false);
      if (context.mounted) {
        context.loaderOverlay.hide();

        Fluttertoast.showToast(
                msg: "Status has been updated".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
          // }
        });
      }
    });
  } else if (orderStatus == 'Processing' || orderStatus == 'On the way') {
    if (orderStatus == 'Processing') {
      // loading.setLoading(true);
      processingTimeCreatedFunc(orderModel.uid);
      PushNotificationFunction.sendPushNotification(
          'Order notification', 'Your order is Processing', userToken);
      if (orderModel.deliveryAddress.isNotEmpty) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "Assign a rider to this order".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
      } else {
        context.loaderOverlay.hide();
      }
   
    } else {
      // loading.setLoading(true);
      onthewayTimeCreatedFunc(orderModel.uid);
      PushNotificationFunction.sendPushNotification(
          'Order notification', 'Your order is on the way', userToken);
    
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pop(context);
        }
      });
    }
    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderModel.uid)
        .update({
      'status': orderStatus,
      //  'acceptDelivery': true
    }).then((value) {
      if (context.mounted) {
        // loading.setLoading(false);
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "Status has been updated".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
      }
    });
  } else {
    if (orderStatus == 'Pending') {
      // loading.setLoading(true);
      pendingTimeCreatedFunc(orderModel.uid);
      PushNotificationFunction.sendPushNotification(
          'Order notification', 'Your order has been Pending', userToken);
   
    } else {
      // // loading.setLoading(true);
      // var commission = ref.watch(getAdminCommissionProvider);
      // var riderCharge = ref.watch(getRiderChargeProvider);
      // logger.d(commission.value);
      // commission.whenData((c) {
      //   riderCharge.whenData((r) {
      //     deliveredTimeCreatedFunc(orderModel, r, c);
      //   });
      // });
      logger.d('DeliveryBoyID is: ${orderModel.deliveryBoyID}');
      PushNotificationFunction.sendPushNotification(
          'Order notification', 'Your order has been Delivered', userToken);

    }
    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderModel.uid)
        .update({'status': orderStatus}).then((value) {
      // loading.setLoading(false);
      if (context.mounted) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "Status has been updated".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
      }
    });
  }
}

deliveredTimeCreatedFunc(OrderModel2 orderModel, dynamic riderCharge,
    num commission, num vendorCharge) {
  logger.d('Rider wallet update section');
  for (var element in orderModel.orders) {
    if (element.vendorId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(element.vendorId)
          .get()
          .then((value) {
        FirebaseFirestore.instance
            .collection('vendors')
            .doc(element.vendorId)
            .update({
          'wallet': value['wallet'] +
              ((element.quantity * element.selectedPrice) -
                  ((element.quantity * element.selectedPrice * vendorCharge) /
                      100))
        });
        FirebaseFirestore.instance.collection('Admin').doc('Admin').update({
          'commission': commission +
              ((element.quantity * element.selectedPrice * vendorCharge) / 100)
        });
        PushNotificationFunction.sendPushNotification(
            'Payment for order',
            '${((element.quantity * element.selectedPrice) - ((element.quantity * element.selectedPrice * vendorCharge) / 100))}',
            value['tokenID']);
      });
      historyVendor(
          HistoryModel(
              message: 'Payment for order',
              amount:
                  '${((element.quantity * element.selectedPrice) - ((element.quantity * element.selectedPrice * vendorCharge) / 100))}',
              paymentSystem: 'Wallet',
              timeCreated: DateTime.now()),
          element.vendorId);
    }
  }

  FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderModel.uid)
      .update({'DeliveredTimeCreated': DateTime.now()}).then((v) {
    if (orderModel.deliveryBoyID.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('riders')
          .doc(orderModel.deliveryBoyID)
          .get()
          .then((value) {
        FirebaseFirestore.instance
            .collection('riders')
            .doc(orderModel.deliveryBoyID)
            .update({
          'isActive': false,
          'wallet': FieldValue.increment(((orderModel.deliveryFee) -
              ((orderModel.deliveryFee * riderCharge) / 100)))
        });
        FirebaseFirestore.instance.collection('Admin').doc('Admin').update({
          'commission': FieldValue.increment(
              ((orderModel.deliveryFee * riderCharge) / 100))
        });
        PushNotificationFunction.sendPushNotification(
            'Payment for order',
            '${((orderModel.deliveryFee) - ((orderModel.deliveryFee * riderCharge) / 100))}',
            value['tokenID']);
      });
      historyRider(
          HistoryModel(
              message: 'Payment for order',
              amount:
                  '${((orderModel.deliveryFee) - ((orderModel.deliveryFee * riderCharge) / 100))}',
              paymentSystem: 'Wallet',
              timeCreated: DateTime.now()),
          orderModel.deliveryBoyID);
    }
  });
}

pendingTimeCreatedFunc(String orderID) {
  FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderID)
      .update({'PendingTimeCreated': DateTime.now()});
}

acceptedTimeCreatedFunc(String orderID) {
  FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderID)
      .update({'acceptedTimeCreated': DateTime.now()});
}

onthewayTimeCreatedFunc(String orderID) {
  FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderID)
      .update({'onthewayTimeCreated': DateTime.now()});
}

processingTimeCreatedFunc(String orderID) {
  FirebaseFirestore.instance.collection('Orders').doc(orderID).update({
    'processingTimeCreated': DateTime.now(),
    'deliveryBoyID': '',
    'acceptDelivery': false
  });
}

@riverpod
Stream<List<UserModel>> getRiders(Ref ref) {
  return FirebaseFirestore.instance
      .collection('riders')
      .where('isActive', isEqualTo: false)
      .where('approval', isEqualTo: true)
      .snapshots()
      .map((e) => e.docs
          .map((element) => UserModel.fromMap(element.data(), element.id))
          .toList());
}

@riverpod
Future<void> assignRider(
    Ref ref, String rider, OrderModel2 orderModel, BuildContext context) async {
  await FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderModel.uid)
      .update({
    'deliveryBoyID': rider,
  }).then((value) {
    FirebaseFirestore.instance
        .collection('riders')
        .doc(rider)
        .get()
        .then((value) {
      PushNotificationFunction.sendPushNotification('New Delivery Request',
          'You have a new delivery request', value['tokenID']);
    });
    if (context.mounted) {
      Fluttertoast.showToast(
          msg: "Delivery has been assigned".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  });
}

@riverpod
Future<void> cancelRider(
    Ref ref, OrderModel2 orderModel, BuildContext context) async {
  await FirebaseFirestore.instance
      .collection('Orders')
      .doc(orderModel.uid)
      .update({
    'deliveryBoyID': '',
  });
  //.then((value) {
  // FirebaseFirestore.instance
  //     .collection('riders')
  //     .doc(rider)
  //     .get()
  //     .then((value) {
  //   PushNotificationFunction.sendPushNotification('New Delivery Request',
  //       'You have a new delivery request', value['tokenID']);
  // });
  if (context.mounted) {
    Fluttertoast.showToast(
        msg: "Delivery has been cancelled".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  // });
}

@riverpod
Future<UserModel> getRiderDetail(Ref ref, OrderModel2 orderModel) async {
  var doc = await FirebaseFirestore.instance
      .collection('riders')
      .doc(orderModel.deliveryBoyID)
      .get();
  return UserModel.fromMap(doc.data()!, doc.id);
}

@riverpod
Future<bool> getEnableRiderStatusDetails(Ref ref) async {
  var doc = await FirebaseFirestore.instance
      .collection('Enable Rider System')
      .doc('Enable Rider System')
      .get();
  return doc['Status'];
}

@riverpod
class LoadingProvider extends _$LoadingProvider {
  @override
  bool build() {
    return false;
  }

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

@riverpod
Future<String> getEmailDetails(Ref ref) async {
  var doc = await FirebaseFirestore.instance
      .collection('Business Details')
      .doc('email')
      .get();
  return doc.data()!['email'];
}
