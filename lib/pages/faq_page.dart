import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final QuillController _controller = QuillController.basic();
  String about = '';
  getFAQDetails() async {
    var value =
        await FirebaseFirestore.instance.collection('FAQ').doc('FAQ').get();
    setState(() {
      about = value['FAQ'];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFAQDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (about.isNotEmpty) {
      _controller.document = Document.fromJson(jsonDecode(about));
      _controller.readOnly = true;
    }
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1100
          ? null
          : AppBar(
              // leading: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: InkWell(
              //       hoverColor: Colors.transparent,
              //       onTap: () {
              //         context.push('/');
              //       },
              //       child: const Icon(Icons.arrow_back)),
              // ),
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: const Text('FAQ').tr(),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark == true
                      ? Colors.black
                      : const Color.fromARGB(255, 230, 224, 237),
                  image: const DecorationImage(
                      opacity: 0.3,
                      image: AssetImage('assets/image/insurance.png'))),
              child: Center(
                child: const Text(
                  'FAQ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ).tr(),
              ),
            ),
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 100, right: 100)
                  : const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.r),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor.basic(
                    
                      configurations:  QuillEditorConfigurations(  controller: _controller,),
                    ),
                  ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Use Of The Site',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Registration',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Password & Security',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Consent',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Information We Collect',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Log Files',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  const Gap(20),
                ],
              ),
            ),
            //const FooterWidget()
          ],
        ),
      ),
    );
  }
}
