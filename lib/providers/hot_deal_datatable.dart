import 'package:riverpod/riverpod.dart';
import 'package:vendor_app/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'hot_deal_datatable.g.dart';
@riverpod
Stream<List<ProductsModel>> hotDealsStream( Ref ref) {
  return FirebaseFirestore.instance
      .collection('Hot Deals')
      .snapshots()
      .map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      return snapshot.docs.map((doc) {
        return ProductsModel.fromMap(doc.data(), doc.id);
      }).toList();
    }
  });
}