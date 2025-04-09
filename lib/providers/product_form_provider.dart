// ignore_for_file: avoid_build_context_in_providers
import 'dart:io';
import 'dart:typed_data';
import 'package:vendor_app/model/products_model.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_form_provider.g.dart';

var logger = Logger();

@riverpod
class ProductFormProvider extends _$ProductFormProvider {
  void updateProduct({
    Uint8List? imageFile1,
    Uint8List? imageFile2,
    Uint8List? imageFile3,
    String? uid,
    String? name,
    String? category,
    String? collection,
    String? subCollection,
    String? image1,
    String? image2,
    String? image3,
    String? unitname1,
    String? unitname2,
    String? unitname3,
    String? unitname4,
    String? unitname5,
    String? unitname6,
    String? unitname7,
    num? unitPrice1,
    num? unitPrice2,
    num? unitPrice3,
    num? unitPrice4,
    num? unitPrice5,
    num? unitPrice6,
    num? unitPrice7,
    num? unitOldPrice1,
    num? unitOldPrice2,
    num? unitOldPrice3,
    num? unitOldPrice4,
    num? unitOldPrice5,
    num? unitOldPrice6,
    num? unitOldPrice7,
    num? percantageDiscount,
    String? vendorId,
    String? brand,
    String? marketID,
    String? marketName,
    String? description,
    String? productID,
    num? totalRating,
    num? totalNumberOfUserRating,
    int? quantity,
    String? endFlash,
    int? returnDuration,
    DateTime? timeCreated,
  }) {
    state = state.copyWith(
      imageFile1: imageFile1 ?? state.imageFile1,
      imageFile2: imageFile2 ?? state.imageFile2,
      imageFile3: imageFile3 ?? state.imageFile3,
      uid: uid ?? state.uid,
      name: name ?? state.name,
      category: category ?? state.category,
      collection: collection ?? state.collection,
      subCollection: subCollection ?? state.subCollection,
      image1: image1 ?? state.image1,
      image2: image2 ?? state.image2,
      image3: image3 ?? state.image3,
      unitname1: unitname1 ?? state.unitname1,
      unitname2: unitname2 ?? state.unitname2,
      unitname3: unitname3 ?? state.unitname3,
      unitname4: unitname4 ?? state.unitname4,
      unitname5: unitname5 ?? state.unitname5,
      unitname6: unitname6 ?? state.unitname6,
      unitname7: unitname7 ?? state.unitname7,
      unitPrice1: unitPrice1 ?? state.unitPrice1,
      unitPrice2: unitPrice2 ?? state.unitPrice2,
      unitPrice3: unitPrice3 ?? state.unitPrice3,
      unitPrice4: unitPrice4 ?? state.unitPrice4,
      unitPrice5: unitPrice5 ?? state.unitPrice5,
      unitPrice6: unitPrice6 ?? state.unitPrice6,
      unitPrice7: unitPrice7 ?? state.unitPrice7,
      unitOldPrice1: unitOldPrice1 ?? state.unitOldPrice1,
      unitOldPrice2: unitOldPrice2 ?? state.unitOldPrice2,
      unitOldPrice3: unitOldPrice3 ?? state.unitOldPrice3,
      unitOldPrice4: unitOldPrice4 ?? state.unitOldPrice4,
      unitOldPrice5: unitOldPrice5 ?? state.unitOldPrice5,
      unitOldPrice6: unitOldPrice6 ?? state.unitOldPrice6,
      unitOldPrice7: unitOldPrice7 ?? state.unitOldPrice7,
      percantageDiscount: percantageDiscount ?? state.percantageDiscount,
      vendorId: vendorId ?? state.vendorId,
      brand: brand ?? state.brand,
      // marketID: marketID ?? state.marketID,
      // marketName: marketName ?? state.marketName,
      description: description ?? state.description,
      productID: productID ?? state.productID,
      totalRating: totalRating ?? state.totalRating,
      totalNumberOfUserRating:
          totalNumberOfUserRating ?? state.totalNumberOfUserRating,
      quantity: quantity ?? state.quantity,
      endFlash: endFlash ?? state.endFlash,
      returnDuration: returnDuration ?? state.returnDuration,
      timeCreated: timeCreated ?? state.timeCreated,
    );
  }

  @override
  ProductsModel build() {
    state = ProductsModel.empty();
    return state;
  }

  Future<void> uploadImage1(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      state = state.copyWith(isLoading: true);
      return value;
    });

    if (result != null) {
      dynamic fileBytes = result.files.first.path;

      state = state.copyWith(imageFile1: fileBytes);
      logger.d('File picked is $fileBytes');
      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putFile(File(fileBytes!));
      String url = await upload.ref.getDownloadURL().then((value) {
        if (state.imageFile1 != null) {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Please wait for image to uplaod",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        if (state.image1 != '') {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Image successfully uploded",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        return value;
      });
      state = state.copyWith(image1: url);
      // state.image1 = url;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> uploadImage2(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      state = state.copyWith(isLoading: true);

      return value;
    });

    if (result != null) {
      dynamic fileBytes = result.files.first.path;
      //String fileName = result.files.first.name;

      state = state.copyWith(imageFile2: fileBytes);

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putFile(File(fileBytes!));
      String url = await upload.ref.getDownloadURL().then((value) {
        if (state.imageFile2 != null) {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Please wait for image to uplaod",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        if (state.image2 != '') {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Image successfully uploded",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        return value;
      });

      state = state.copyWith(image2: url);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> uploadImage3(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      state = state.copyWith(isLoading: true);

      return value;
    });

    if (result != null) {
      dynamic fileBytes = result.files.first.path;

      state = state.copyWith(imageFile3: fileBytes);

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putFile(File(fileBytes!));
      String url = await upload.ref.getDownloadURL().then((value) {
        if (state.imageFile3 != null) {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Please wait for image to uplaod",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        if (state.image3 != '') {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Image successfully uploded",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        return value;
      });

      state = state.copyWith(image3: url);
      state = state.copyWith(isLoading: false);
    }
  }

  addProduct(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Products')
        .doc(id)
        .set(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Added Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  editProduct(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Products')
        .doc(id)
        .update(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Updated Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  editFlashSales(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Flash Sales')
        .doc(id)
        .update(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Updated Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  editDeal(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Hot Deals')
        .doc(id)
        .update(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Updated Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  addFlashSales(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Flash Sales')
        .doc(id)
        .set(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Added Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  addHotDeals(ProductsModel products, String id, BuildContext context) {
    state = state.copyWith(isLoading: true);
    FirebaseFirestore.instance
        .collection('Hot Deals')
        .doc(id)
        .set(products.toMap())
        .then((value) {
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        Fluttertoast.showToast(
                msg: "Product Added Successfully...".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0)
            .then((v) {});
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }
}
