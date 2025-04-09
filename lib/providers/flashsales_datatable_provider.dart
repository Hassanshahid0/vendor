import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/products_model.dart';
part 'flashsales_datatable_provider.g.dart';

@riverpod
Stream<List<ProductsModel>> flashsalesStream( Ref ref) {
  return FirebaseFirestore.instance
      .collection('Flash Sales')
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

@riverpod
Future<String> currencySymbol( Ref ref) async {
  final doc = await FirebaseFirestore.instance
      .collection('Currency Settings')
      .doc('Currency Settings')
      .get();
  return doc['Currency symbol'];
}

@riverpod
Stream<String> flashSalesTimeStream( Ref ref) {
  return FirebaseFirestore.instance
      .collection('Flash Sales Time')
      .doc('Flash Sales Time')
      .snapshots()
      .map((doc) => doc.exists ? doc['Flash Sales Time'] : '');
}

@riverpod
Future<void> setFlashSalesTime(
     Ref ref, String flashSalesTime) async {
  await FirebaseFirestore.instance
      .collection('Flash Sales Time')
      .doc('Flash Sales Time')
      .set({'Flash Sales Time': flashSalesTime});
}

@riverpod
Future<void> deleteFlashSalesCollection(
     Ref ref) async {
  FirebaseFirestore.instance
      .collection('Flash Sales Time')
      .doc('Flash Sales Time')
      .set({'Flash Sales Time': ''});
  final snapshot =
      await FirebaseFirestore.instance.collection('Flash Sales').get();
  for (final ds in snapshot.docs) {
    await ds.reference.delete();
  }
}
