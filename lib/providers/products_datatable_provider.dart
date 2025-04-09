import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/products_model.dart';
part 'products_datatable_provider.g.dart';

bool isLoading = false;

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  List<ProductsModel> build() {
    _getProducts();
    return [];
  }

  void _getProducts() {
    isLoading = true;
    FirebaseFirestore.instance
        .collection('Products')
        .snapshots()
        .listen((event) {
      var logger = Logger();
      isLoading = false;
      logger.d("Logger is working!");
      state =
          event.docs.map((doc) => ProductsModel.fromMap(doc, doc.id)).toList();
    });
  }

  Future<void> deleteProduct(
    // ignore: avoid_build_context_in_providers
    BuildContext context,
    String productId,
    String productName,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .delete();

      // Update the state to remove the deleted product
      state = state.where((product) => product.uid != productId).toList();

      // Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        // Show success notification
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification".tr(),
          message: "Deleted successfully!!!".tr(),
          duration: const Duration(seconds: 3),
        ).show(context).then((v) {
          if (context.mounted) {
            context.pop();
          }
        });
      }
    } catch (e) {
      if (context.mounted) {
        // Handle any errors here
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Error".tr(),
          message: "Failed to delete product: ${e.toString()}".tr(),
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }
}

@riverpod
Future<List<String>> getCategories(Ref ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Categories').get();
  return snapshot.docs.map((e) => e.data()['category'] as String).toList();
}

@riverpod
Future<List<String>> getSubCollections(
    Ref ref, String category, String collection) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Sub Collections')
      .where('category', isEqualTo: category)
      .where('collection', isEqualTo: collection)
      .get();
  return snapshot.docs.map((e) => e.data()['subCollection'] as String).toList();
}

@riverpod
Future<List<String>> getCollections(Ref ref, String category) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Collections')
      .where('category', isEqualTo: category)
      .get();
  return snapshot.docs.map((e) => e.data()['collection'] as String).toList();
}

@riverpod
Future<List<String>> getBrands(Ref ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Brands')
      // .where('category', isEqualTo: category)
      .get();
  return snapshot.docs.map((e) => e.data()['collection'] as String).toList();
}
