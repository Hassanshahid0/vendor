import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
   // context.push('/');
    GoRouter.of(context).go('/');
  }

  Widget buildFullscreenImage() {
    return Image.asset(
      'assets/image/undraw 1.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/image/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('icon.png', 100),
      //     ),
      //   ),
      // ),

      pages: [
        PageViewModel(
          title: "Choose best products for you and your family...",
          body:
              "The app connects you to a Olivette Store to purchase your goods.",
          image: _buildImage('undraw 2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: " Get affordable products at a cheaper rate",
          body: "Get products at discount price.",
          image: _buildImage('undraw 3.png'),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Make your own order",
        //   body:
        //       "Send your packages to your loved ones.",
        //   image: _buildImage('cart new.png'),
        //   decoration: pageDecoration.copyWith(
        //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        //     fullScreen: false,
        //     bodyFlex: 2,
        //     imageFlex: 3,
        //   ),
        // ),
        PageViewModel(
          image: _buildImage('undraw 4.png'),
          title: "Connect to us directly for customizations and other FAQ's...",
          bodyWidget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Click on Done", style: bodyStyle),
              Text(" to continue", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back,
          color: Color.fromARGB(243, 108, 99, 255)),
      skip: const Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(243, 108, 99, 255))),
      next: const Icon(Icons.arrow_forward,
          color: Color.fromARGB(243, 108, 99, 255)),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(243, 108, 99, 255))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        activeColor: Color.fromARGB(243, 108, 99, 255),
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
