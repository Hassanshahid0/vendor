
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../constant.dart';
import 'package:vendor_app/providers/auth.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();
  final _emailFieldKeyLogin = GlobalKey<FormBuilderFieldState>();
  bool showPassword = true;
  String email = '';
  String password = '';
  String tokenID = '';

  // Controllers and Focus Nodes
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    getTokenID();
    super.initState();
  }

  getTokenID() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      tokenID = token!;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKeyLogin,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (MediaQuery.of(context).size.width <= 1100) const Gap(50),
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
                  'Sign in to continue.',
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
                controller: _emailController,
                focusNode: _emailFocusNode,
                autofocus: false,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
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
                  // fillColor: Theme.of(context).colorScheme.secondaryBackground,
                  hintText: 'Email'.tr(),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                minLines: 1,
                keyboardType: TextInputType.emailAddress,
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
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: showPassword, // Toggle password visibility
                decoration: InputDecoration(
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
                  // fillColor: Theme.of(context).colorScheme.secondaryBackground,
                  hintText: 'Password'.tr(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword; // Toggle visibility
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
              ),
            ),

            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.push('/forgot-password');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: appColor),
                    ).tr(),
                  ),
                ],
              ),
            ),
            const Gap(20),
            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.orange,
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () {
                  if (_formKeyLogin.currentState!.validate()) {
                    context.loaderOverlay.show();
                    AuthService()
                        .signIn(email, password, context, tokenID)
                        .then((value) {
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                      }
                    });
                  }
                },
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ).tr(),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left divider line
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 6
                      : MediaQuery.of(context).size.width / 3, // Adjust line length based on screen size
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width >= 1100 ? 16 : 14, // Adjust text size
                    ),
                  ),
                ),
                // Right divider line
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 6
                      : MediaQuery.of(context).size.width / 3, // Adjust line length based on screen size
                  color: Colors.grey,
                ),
              ],
            ),

            const Gap(20),
            SizedBox(
              width: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: GoogleAuthButton(
                style: AuthButtonStyle(
                  elevation: 0,
                  textStyle: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.white
                          : Colors.black),
                  buttonColor: AdaptiveTheme.of(context).mode.isDark == true
                      ? Colors.black
                      : Colors.white,
                  iconType: AuthIconType.secondary,
                ),
                onPressed: () {
                  AuthService().signInWithGoogle(context, tokenID);
                },
              ),
            ),
            
            
          ],
        ),
      ),
    );

  }
}
