import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../constant.dart';
import 'add_delivery_address.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  //GlobalKey<FormBuilderState> formKeyNew = GlobalKey<FormBuilderState>();
  String fullname = '';
  String phoneNumber = '';
  String email = '';
  String address = '';
  String referralCode = '';
  bool isLoading = true;
  bool approval = false;
  String photoUrl = '';

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   setState(() {
  //     tokenID = token!;
  //   });
  // }
  getUserDetail() {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('vendors')
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoading = false;
        fullname = event['fullname'];
        email = event['email'];
        phoneNumber = event['phone'];
        approval = event['approval'];
        referralCode = event['personalReferralCode'];
        address = event['address'];
        photoUrl = event['photoUrl'];
      });
      //  print('Fullname is $fullName');
    });
  }

  @override
  void initState() {
    // getToken();
    getUserDetail();
    super.initState();
  }

  updateUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (phoneNumber.length == 14) {
      FirebaseFirestore.instance.collection('vendors').doc(user!.uid).update({
        'fullname': fullname,
        //'email':email,
        'phone': phoneNumber,
        'address': address,
        'photoUrl': photoUrl
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Update completed".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            fontSize: 14.0);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please check the phone number and try again.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0);
    }
  }

  XFile? imageFile;
  bool? loading;
  Future<void> _upload() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image;
      loading = true;
    });
    if (imageFile != null) {
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child(imageFile!.path)
          .putFile(File(imageFile!.path));
      String downloadUrl =
          await snapshot.ref.getDownloadURL().whenComplete(() => setState(() {
                loading = false;
              }));

      setState(() {
        photoUrl = downloadUrl;
      });
      debugPrint(photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white,
                  ),
                  subtitle: Container(
                    width: double.infinity,
                    height: 12.0,
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        : FormBuilder(
            //  key: formKeyNew,
            child: Column(
              mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(10),
                Text('Approval Status: $approval'),
                if (MediaQuery.of(context).size.width >= 1100)
                  Align(
                    alignment: MediaQuery.of(context).size.width >= 1100
                        ? Alignment.bottomLeft
                        : Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width >= 1100
                              ? 50
                              : 0),
                      child: Text(
                        'Account Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width >= 1100
                                ? 15
                                : 15),
                      ).tr(),
                    ),
                  ),
                Stack(
                  children: [
                    imageFile != null
                        ? ClipOval(
                            child: Image.file(
                            File(imageFile!.path),
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ))
                        : ClipOval(
                            child: CachedNetworkImage(
                              height: photoUrl == '' ? 90 : 120,
                              fit: BoxFit.cover,
                              width: 120,
                              imageUrl: photoUrl == ''
                                  ? "https://t4.ftcdn.net/jpg/01/07/57/91/360_F_107579101_QVlTG43Fwg9Q6ggwF436MPIBTVpaKKtb.jpg"
                                  : photoUrl,
                              placeholder: (context, url) => SpinKitRing(
                                color: appColor,
                                size: 30,
                                lineWidth: 3,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appColor,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              _upload();
                            },
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                if (MediaQuery.of(context).size.width >= 1100)
                  const Divider(
                    color: Color.fromARGB(255, 237, 235, 235),
                    thickness: 1,
                  ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Full Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 12),
                    ).tr(),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width >= 1100 ? 50 : 8,
                      right:
                          MediaQuery.of(context).size.width >= 1100 ? 50 : 8),
                  child: FormBuilderTextField(
                    onChanged: (v) {
                      setState(() {
                        fullname = v!;
                      });
                    },
                    initialValue: fullname,
                    name: 'full name',
                    decoration: const InputDecoration(
                        // filled: true,
                        // // border: InputBorder.none,
                        // fillColor: Colors.white,
                        // hintText: 'Email'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 12),
                    ).tr(),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width >= 1100 ? 50 : 8,
                      right:
                          MediaQuery.of(context).size.width >= 1100 ? 50 : 8),
                  child: FormBuilderTextField(
                    readOnly: true,
                    onChanged: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    initialValue: email,
                    name: 'email address',
                    decoration: const InputDecoration(
                        // filled: true,
                        // // border: InputBorder.none,
                        // fillColor: Colors.white,
                        // hintText: 'Email'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 12),
                    ).tr(),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width >= 1100 ? 50 : 8,
                      right:
                          MediaQuery.of(context).size.width >= 1100 ? 50 : 8),
                  child: FormBuilderTextField(
                    maxLength: 14,
                    onChanged: (v) {
                      setState(() {
                        phoneNumber = v!;
                      });
                    },
                    initialValue: phoneNumber,
                    name: 'phone number',
                    decoration: const InputDecoration(
                        counterText: '',
                        // filled: true,
                        // // border: InputBorder.none,
                        // fillColor: Colors.white,
                        // hintText: 'Email'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 12),
                    ).tr(),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width >= 1100 ? 50 : 8,
                      right:
                          MediaQuery.of(context).size.width >= 1100 ? 50 : 8),
                  child: FormBuilderTextField(
                    readOnly: true,
                    onChanged: (v) {
                      setState(() {
                        address = v!;
                      });
                    },
                    // initialValue: address,
                    name: 'address',
                    decoration: InputDecoration(
                        // filled: true,
                        // // border: InputBorder.none,
                        // fillColor: Colors.white,
                        hintText: address,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const OpenStreet();
                              }));
                              // _navigateAndDisplaySelection(context);
                              setState(() {
                                address = result;
                              });
                            },
                            icon: const Icon(Icons.add_circle)),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 20),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const BeveledRectangleBorder(),
                        backgroundColor: appColor,
                        textStyle: const TextStyle(color: Colors.white)),
                    // color: Theme.of(context).colorScheme.secondary,
                    onPressed: loading == true
                        ? null
                        : () {
                            updateUser();
                            // if (formKeyNew.currentState!.validate()) {
                            //   // context.loaderOverlay.show();
                            //   // AuthService()
                            //   //     .signIn(email, password, context, tokenID)
                            //   //     .then((value) {
                            //   //   context.loaderOverlay.hide();
                            //   // });
                            //   // Validate and save the form values
                            //   // _formKey.currentState?.saveAndValidate();
                            //   // debugPrint(_formKey.currentState?.value.toString());

                            //   // // On another side, can access all field values without saving form with instantValues
                            //   // _formKey.currentState?.validate();
                            //   //   debugPrint(_formKey.currentState?.instantValue.toString());
                            // }
                          },
                    child: const Text(
                      'UPDATE PROFILE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).tr(),
                  ),
                ),
                const Gap(20),
              ],
            ),
          );
  }
}
