import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Database with ChangeNotifier {
  final String uid;
  Database({required this.uid});

  // collection reference
  final CollectionReference signUpCollection =
      FirebaseFirestore.instance.collection('vendors');

//update C\:\\Usersdel signup page
  Future<void> updateUserData(
    String email,
    String fullname,
    String phone,
    String tokenID,
    String referralCode,
  ) async {
    notifyListeners();
    return await signUpCollection.doc(uid).set({
      'email': email,
      'fullname': fullname,
      'created': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      'id': uid,
      'phone': phone,
      'photoUrl': '',
      'address': '',
      'DeliveryAddress': '',
      'HouseNumber': '',
      'ClosestBustStop': '',
      'DeliveryAddressID': '',
      'CurrentMarketID': '',
      'deliveryFee': 0,
      'wallet': 0,
      'tokenID': tokenID,
      'referralCode': referralCode,
      'awardReferral': false,
      'personalReferralCode': '',
      'Coupon Reward': 0,
      'approval': false
    });
  }
}
