import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendor_app/model/order_model.dart';

part 'orders_provider.g.dart';

@riverpod
Stream<List<OrderModel2>> ordersStream(Ref ref, String status) async* {
  final query = (status == 'All')
      ? FirebaseFirestore.instance.collection('Orders')
      : status == 'Pickup'
          ? FirebaseFirestore.instance
              .collection('Orders')
              .where('deliveryAddress', isEqualTo: '')
          : FirebaseFirestore.instance
              .collection('Orders')
              .where('status', isEqualTo: status);

  await for (var snapshot in query.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      final orders = snapshot.docs.map((doc) {
        return OrderModel2(
          orders: (doc.data()['orders'] as List).map((item) {
            return OrdersList.fromMap(item);
          }).toList(),
          pickupStorename: doc.data()['pickupStorename'],
          pickupPhone: doc.data()['pickupPhone'],
          pickupAddress: doc.data()['pickupAddress'],
          instruction: doc.data()['instruction'],
          couponPercentage: doc.data()['couponPercentage'],
          couponTitle: doc.data()['couponTitle'],
          useCoupon: doc.data()['useCoupon'],
          confirmationStatus: doc.data()['confirmationStatus'],
          uid: doc.data()['uid'],
          // marketID: doc.data()['marketID'],
          vendorIDs: [
            ...(doc.data()['vendorIDs']).map((items) {
              return items;
            })
          ],
          userID: doc.data()['userID'],
          deliveryAddress: doc.data()['deliveryAddress'],
          houseNumber: doc.data()['houseNumber'],
          closesBusStop: doc.data()['closesBusStop'],
          deliveryBoyID: doc.data()['deliveryBoyID'],
          status: doc.data()['status'],
          accept: doc.data()['accept'],
          orderID: doc.data()['orderID'],
          timeCreated: doc.data()['timeCreated'].toDate(),
          total: doc.data()['total'],
          deliveryFee: doc.data()['deliveryFee'],
          acceptDelivery: doc.data()['acceptDelivery'],
          paymentType: doc.data()['paymentType'],
        );
      }).toList();

      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
      yield orders;
    }
  }
}
