// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import '../constant.dart';
// import 'package:vendor_app/providers/auth.dart';
//
// class SignupFormWidget extends StatefulWidget {
//   const SignupFormWidget({super.key});
//
//   @override
//   State<SignupFormWidget> createState() => _SignupFormWidgetState();
// }
//
// class _SignupFormWidgetState extends State<SignupFormWidget> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
//   bool showPassword = true;
//   String fullname = '';
//   String email = '';
//   String phone = '';
//   String password = '';
//   String dailCode = '+92';
//   // final _formKey = GlobalKey<FormState>();
//   // Timer? oneSignalTimer;
//   String playerId = '';
//   String getOnesignalKey = '';
//   String referralCode = '';
//   bool referralStatus = false;
//   num? reward;
//   // void _retrieveToken() async {
//   //   String? token = await FirebaseMessaging.instance.getToken();
//   //   setState(() {
//   //     playerId = token!;
//   //   });
//   //   // ignore: avoid_print
//   //   print('FCM Token: $token');
//   // }
//
//   @override
//   void initState() {
//     // _retrieveToken();
//     getTokenID();
//     // getReferralStatus();
//     super.initState();
//   }
//
//   getTokenID() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       playerId = token!;
//     });
//   }
//
//   getReferralStatus() {
//     FirebaseFirestore.instance
//         .collection('Referral System')
//         .doc('Referral System')
//         .snapshots()
//         .listen((value) {
//       setState(() {
//         referralStatus = value['Status'];
//         reward = value['Referral Amount'];
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: FormBuilder(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
//               ? MainAxisAlignment.center
//               : MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //   if (MediaQuery.of(context).size.width <= 1100) const Gap(50),
//             if (MediaQuery.of(context).size.width <= 1100)
//               Image.asset(
//                 logo,
//                 scale: 1,
//               ),
//             const Gap(10),
//             Align(
//               alignment: MediaQuery.of(context).size.width >= 1100
//                   ? Alignment.bottomLeft
//                   : Alignment.center,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
//                 child: Text(
//                   'Sign up to continue.',
//                   style: TextStyle(
//                       color: appColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize:
//                           MediaQuery.of(context).size.width >= 1100 ? 20 : 15),
//                 ).tr(),
//               ),
//             ),
//             const Gap(20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               child: FormBuilderTextField(
//                 style: TextStyle(
//                   color: AdaptiveTheme.of(context).mode.isDark == true
//                       ? Colors.black
//                       : null,
//                 ),
//                 name: 'full_name',
//                 onChanged: (v) {
//                   setState(() {
//                     fullname = v!;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   filled: true,
//                   border: InputBorder.none,
//                   fillColor: const Color.fromARGB(255, 236, 234, 234),
//                   hintStyle: TextStyle(
//                       color: AdaptiveTheme.of(context).mode.isDark == true
//                           ? Colors.black
//                           : null),
//                   hintText: 'Full name'.tr(),
//                   //border: OutlineInputBorder()
//                 ),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(),
//                 ]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               child: FormBuilderTextField(
//                 style: TextStyle(
//                   color: AdaptiveTheme.of(context).mode.isDark == true
//                       ? Colors.black
//                       : null,
//                 ),
//                 onChanged: (v) {
//                   setState(() {
//                     email = v!;
//                   });
//                 },
//                 key: _emailFieldKey,
//                 name: 'email',
//                 decoration: InputDecoration(
//                   filled: true,
//                   border: InputBorder.none,
//                   fillColor: const Color.fromARGB(255, 236, 234, 234),
//                   hintStyle: TextStyle(
//                       color: AdaptiveTheme.of(context).mode.isDark == true
//                           ? Colors.black
//                           : null),
//                   hintText: 'Email'.tr(),
//                   //border: OutlineInputBorder()
//                 ),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(),
//                   FormBuilderValidators.email(),
//                 ]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               child: Row(
//                 children: [
//                   CountryCodePicker(
//                     dialogTextStyle: TextStyle(
//                       color: AdaptiveTheme.of(context).mode.isDark == true
//                           ? Colors.black
//                           : const Color.fromARGB(255, 236, 234, 234),
//                     ),
//                     showDropDownButton: true,
//                     //    backgroundColor: Color.fromARGB(255, 236, 234, 234),
//                     onChanged: (v) {
//                       setState(() {
//                         dailCode = v.dialCode!;
//                       });
//                     },
//                     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                     initialSelection: 'NG',
//                     // favorite: const ['+39', 'FR'],
//                     //  countryFilter: const ['IT', 'FR'],
//                     showFlagDialog: true,
//                     comparator: (a, b) => b.name!.compareTo(a.name!),
//                     //Get the country information relevant to the initial selection
//                     onInit: (code) {
//                       // setState(() {
//                       //   dailCode = code!.dialCode!;
//                       // });
//                     },
//                   ),
//                   Expanded(
//                     flex: 6,
//                     child: FormBuilderTextField(
//                       style: TextStyle(
//                         color: AdaptiveTheme.of(context).mode.isDark == true
//                             ? Colors.black
//                             : null,
//                       ),
//                       onChanged: (v) {
//                         setState(() {
//                           phone = v!;
//                         });
//                       },
//                       name: 'number',
//                       maxLength: 10,
//                       decoration: InputDecoration(
//                         filled: true,
//                         counterText: "",
//                         border: InputBorder.none,
//                         fillColor: const Color.fromARGB(255, 236, 234, 234),
//                         hintStyle: TextStyle(
//                             color: AdaptiveTheme.of(context).mode.isDark == true
//                                 ? Colors.black
//                                 : null),
//                         hintText: 'XXXX XXX XXX',
//                         //border: OutlineInputBorder()
//                       ),
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.numeric()
//                       ]),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               child: FormBuilderTextField(
//                 style: TextStyle(
//                   color: AdaptiveTheme.of(context).mode.isDark == true
//                       ? Colors.black
//                       : null,
//                 ),
//                 onChanged: (v) {
//                   setState(() {
//                     password = v!;
//                   });
//                 },
//                 name: 'password',
//                 decoration: InputDecoration(
//                   suffixIcon: showPassword == true
//                       ? InkWell(
//                           onTap: () {
//                             setState(() {
//                               showPassword = false;
//                             });
//                           },
//                           child: const Icon(
//                             Icons.visibility,
//                             color: Colors.grey,
//                             size: 30,
//                           ),
//                         )
//                       : InkWell(
//                           onTap: () {
//                             setState(() {
//                               showPassword = true;
//                             });
//                           },
//                           child: const Icon(
//                             Icons.visibility_off,
//                             color: Colors.grey,
//                             size: 30,
//                           ),
//                         ),
//                   filled: true,
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(
//                       color: AdaptiveTheme.of(context).mode.isDark == true
//                           ? Colors.black
//                           : null),
//                   fillColor: const Color.fromARGB(255, 236, 234, 234),
//                   hintText: 'Password'.tr(),
//                   //   border: OutlineInputBorder()
//                 ),
//                 obscureText: showPassword,
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(),
//                 ]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               child: FormBuilderTextField(
//                 style: TextStyle(
//                   color: AdaptiveTheme.of(context).mode.isDark == true
//                       ? Colors.black
//                       : null,
//                 ),
//                 name: 'confirm_password',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 decoration: InputDecoration(
//                   filled: true,
//                   border: InputBorder.none,
//                   fillColor: const Color.fromARGB(255, 236, 234, 234),
//                   hintStyle: TextStyle(
//                       color: AdaptiveTheme.of(context).mode.isDark == true
//                           ? Colors.black
//                           : null),
//                   hintText: 'Confirm Password'.tr(),
//                   suffixIcon: (_formKey.currentState?.fields['confirm_password']
//                               ?.hasError ??
//                           false)
//                       ? const Icon(Icons.error, color: Colors.red)
//                       : const Icon(Icons.check, color: Colors.green),
//                 ),
//                 obscureText: true,
//                 validator: (value) =>
//                     _formKey.currentState?.fields['password']?.value != value
//                         ? 'No coinciden'.tr()
//                         : null,
//               ),
//             ),
//             // if (referralStatus == true) const SizedBox(height: 20),
//             // if (referralStatus == true)
//             //   SizedBox(
//             //     width: MediaQuery.of(context).size.width >= 1100
//             //         ? MediaQuery.of(context).size.width / 2
//             //         : MediaQuery.of(context).size.width / 1.2,
//             //     child: FormBuilderTextField(
//             //       onChanged: (v) {
//             //         setState(() {
//             //           referralCode = v!;
//             //         });
//             //       },
//             //       name: 'text',
//             //       decoration: InputDecoration(
//             //         filled: true,
//             //         border: InputBorder.none,
//             //         fillColor: const Color.fromARGB(255, 236, 234, 234),
//             //         hintText: 'Referral Code'.tr(),
//             //         //border: OutlineInputBorder()
//             //       ),
//             //       // validator: FormBuilderValidators.compose([
//             //       //   FormBuilderValidators.required(),
//             //       // ]),
//             //     ),
//             //   ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: MediaQuery.of(context).size.width >= 1100
//                   ? const EdgeInsets.only(left: 40, right: 40)
//                   : const EdgeInsets.all(8.0),
//               child: FormBuilderFieldDecoration<bool>(
//                 name: 'test',
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(),
//                   FormBuilderValidators.equal(true),
//                 ]),
//                 // initialValue: true,
//                 decoration: const InputDecoration(labelText: 'Accept Terms?'),
//                 builder: (FormFieldState<bool?> field) {
//                   return InputDecorator(
//                     decoration: InputDecoration(
//                       errorText: field.errorText,
//                     ),
//                     child: SwitchListTile(
//                       title: RichText(
//                         text: TextSpan(
//                             text: 'I have agreed to the'.tr(),
//                             style: TextStyle(
//                               color:
//                                   AdaptiveTheme.of(context).mode.isDark == true
//                                       ? Colors.white
//                                       : Colors.black,
//                               // color: Colors.black,
//                             ),
//                             children: <TextSpan>[
//                               TextSpan(
//                                   text: ' Terms of Services'.tr(),
//                                   style: TextStyle(
//                                     color: appColor,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       context.push('/terms');
//                                     }),
//                               const TextSpan(
//                                 text: ' Olivette Stroe',
//                                 // style: TextStyle(
//                                 //   color: appColor,
//                                 // ),
//                                 // recognizer: TapGestureRecognizer()
//                                 //   ..onTap = () {
//                                 //     context.push('/login');
//                                 //   }
//                               )
//                             ]),
//                       ),
//                       onChanged: field.didChange,
//                       value: field.value ?? false,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Gap(20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width >= 1100
//                   ? MediaQuery.of(context).size.width / 2
//                   : MediaQuery.of(context).size.width / 1.2,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     shape: const BeveledRectangleBorder(),
//                     backgroundColor: Colors.orange,
//                     textStyle: const TextStyle(color: Colors.white)),
//                 // color: Theme.of(context).colorScheme.secondary,
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     context.loaderOverlay.show();
//                     AuthService()
//                         .signUp(
//                             email,
//                             password,
//                             fullname,
//                             '$dailCode$phone',
//                             context,
//                             referralCode,
//                             reward,
//                             referralStatus,
//                             playerId)
//                         .then((value) {
//                       if (context.mounted) {
//                         context.loaderOverlay.hide();
//                       }
//                     });
//                     // Validate and save the form values
//                     // _formKey.currentState?.saveAndValidate();
//                     // debugPrint(_formKey.currentState?.value.toString());
//
//                     // // On another side, can access all field values without saving form with instantValues
//                     // _formKey.currentState?.validate();
//                     //   debugPrint(_formKey.currentState?.instantValue.toString());
//                   }
//                 },
//                 child: Text(
//                   'SIGN UP'.tr(),
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const Gap(20)
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../constant.dart';
import 'package:vendor_app/providers/auth.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _fullNameController = TextEditingController();
  final _fullNameFocusNode = FocusNode();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordController = TextEditingController();
  final _confirmPasswordFocusNode = FocusNode();

  bool showPassword = true;
  bool _acceptTerms = false;
  String fullname = '';
  String email = '';
  String phone = '';
  String password = '';
  String dailCode = '+92';
  String playerId = '';
  String referralCode = '';
  bool referralStatus = false;
  num? reward;

  @override
  void initState() {
    getTokenID();
    super.initState();
  }

  getTokenID() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      playerId = token!;
    });
  }

  getReferralStatus() {
    FirebaseFirestore.instance
        .collection('Referral System')
        .doc('Referral System')
        .snapshots()
        .listen((value) {
      setState(() {
        referralStatus = value['Status'];
        reward = value['Referral Amount'];
      });
    });
  }

  InputDecoration _buildInputDecoration(String hintText, {Widget? suffixIcon}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 236, 234, 234),
      hintText: hintText.tr(),
      hintStyle: TextStyle(
        color: AdaptiveTheme.of(context).mode.isDark == true
            ? Colors.black
            : Colors.grey,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (MediaQuery.of(context).size.width <= 1100)
              Image.asset(
                logo,
                scale: 1,
              ),
            const Gap(10),
            Align(
              alignment: MediaQuery.of(context).size.width >= 1100
                  ? Alignment.bottomLeft
                  : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                child: Text(
                  'Sign up to continue.',
                  style: TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                      fontSize:
                      MediaQuery.of(context).size.width >= 1100 ? 20 : 15),
                ).tr(),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: _fullNameController,
                focusNode: _fullNameFocusNode,
                autofocus: false,
                textInputAction: TextInputAction.next,
                decoration: _buildInputDecoration('Full name'),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    fullname = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                autofocus: false,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                decoration: _buildInputDecoration('Email'),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: Row(
                children: [
                  CountryCodePicker(
                    dialogTextStyle: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.black
                          : const Color.fromARGB(255, 236, 234, 234),
                    ),
                    showDropDownButton: true,
                    onChanged: (v) {
                      setState(() {
                        dailCode = v.dialCode!;
                      });
                    },
                    initialSelection: 'PK',
                    showFlagDialog: true,
                    comparator: (a, b) => b.name!.compareTo(a.name!),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                      decoration: _buildInputDecoration('XXXX XXX XXX'),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                autofocus: false,
                textInputAction: TextInputAction.next,
                obscureText: showPassword,
                decoration: _buildInputDecoration(
                  'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                autofocus: false,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: _buildInputDecoration('Confirm Password'),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            // Privacy Policy Checkbox
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        activeColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.white
                              : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Privacy Policy
                                context.push('/privacy-policy');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Sign Up Button
            Container(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _acceptTerms
                    ? () {
                  if (_formKey.currentState!.validate()) {
                    context.loaderOverlay.show();
                    AuthService()
                        .signUp(
                        email,
                        password,
                        fullname,
                        '$dailCode$phone',
                        context,
                        referralCode,
                        reward,
                        referralStatus,
                        playerId)
                        .then((value) {
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                      }
                    });
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'SIGN UP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}