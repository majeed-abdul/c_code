import 'package:flutter/material.dart';
import 'package:qr_maze/screens/home.dart';
// import 'package:wheels/screens/dash/dash.dart';

class OnBording extends StatefulWidget {
  // const OnBording({Key? key}) : super(key: key);
  const OnBording({super.key});
  static String id = 'onbording/';

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PageController pageController = PageController();
  static const kDuration = Duration(milliseconds: 300);
  static const kCurve = Curves.ease;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.popAndPushNamed(context, Dash.id);
            //   },
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  radius: 20,
                  highlightColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.popAndPushNamed(context, HomeScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Text(
                      'Skip',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: itemsList.length,
                itemBuilder: (BuildContext context, int i) {
                  return Image.asset(itemsList[i].image);
                },
                onPageChanged: (i) => setState(() => index = i),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              itemsList[index].text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemsList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(11),
                      child: CircleAvatar(
                        radius: index == i ? 6 : 5,
                        backgroundColor: index == i
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  },
                ),
              ),
              // child: SizedBox(
              //   height: 30,
              //   child: PageView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: itemsList.length,
              //     controller: pageController,
              //     itemBuilder: (BuildContext context, int i) {
              //       return Padding(
              //         padding: const EdgeInsets.all(11),
              //         child: CircleAvatar(
              //           radius: index == i ? 6 : 5,
              //           backgroundColor: index == i
              //               ? Theme.of(context).colorScheme.primary
              //               : Theme.of(context).colorScheme.secondary,
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ),
            const SizedBox(height: 14),
            InkWell(
              radius: 20,
              highlightColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                if (index >= itemsList.length - 1) {
                  Navigator.popAndPushNamed(context, HomeScreen.id);
                } else {
                  pageController.nextPage(duration: kDuration, curve: kCurve);
                }
                setState(() {});
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class OnBordingItem {
  String image;
  String text;
  OnBordingItem({
    required this.image,
    required this.text,
  });
}

List<OnBordingItem> itemsList = [
  OnBordingItem(
    image: 'assets/onboarding1.png',
    text: "Simple & AdsFree(unless you choose to support us).",
  ),
  OnBordingItem(
    image: 'assets/onboarding2.png',
    text:
        "Don't hesitate to scan random codes, we got your back with our security feature.",
  ),
  OnBordingItem(
    image: 'assets/onboarding3.png',
    text: "You can add quick setting tile for easy access.",
  ),
];
