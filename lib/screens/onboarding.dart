import 'package:flutter/material.dart';
import 'package:qr_maze/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wheels/screens/dash/dash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = 'splash/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;
    // print('======FirstTime $firstTime');
    if (firstTime) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(OnBording.id);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

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
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PageController pageController = PageController();
  static const kDuration = Duration(milliseconds: 700);
  static const kCurve = Curves.ease;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  radius: 20,
                  highlightColor: Theme.of(context).appBarTheme.foregroundColor,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox.square(
              dimension: 400,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: itemsList.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        itemsList[i].image,
                        // height: 350,
                        // width: 350,
                      ),
                    ),
                  );
                },
                onPageChanged: (i) => setState(() => index = i),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  itemsList[index].text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Center(
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemsList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(9),
                      child: CircleAvatar(
                        radius: index == i ? 3.7 : 3,
                        backgroundColor: index == i
                            ? Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor
                            : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 19),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         if (index > 0) {
            //           pageController.previousPage(
            //             duration: kDuration,
            //             curve: kCurve,
            //           );
            //           setState(() {});
            //         }
            //       },
            //       child: Text(
            //         'Previous',
            //         style: TextStyle(
            //           color: Theme.of(context)
            //               .bottomNavigationBarTheme
            //               .selectedItemColor,
            //           // fontSize: 14,
            //         ),
            //       ),
            //     ),
            ElevatedButton(
              onPressed: () async {
                if (index >= itemsList.length - 1) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('firstTime', false).then((value) {
                    // ignore: use_build_context_synchronously
                    Navigator.popAndPushNamed(context, HomeScreen.id);
                  });
                } else {
                  pageController.nextPage(duration: kDuration, curve: kCurve);
                }
                setState(() {});
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                  // fontSize: 14,
                ),
              ),
            ),
            //   ],
            // ),
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
    text: "Simple & ad-free (unless you choose to support us).",
  ),
  OnBordingItem(
    image: 'assets/onboarding2.png',
    text: "Feel free to scan any code, we have your back.",
  ),
  OnBordingItem(
    image: 'assets/onboarding3.png',
    text: "Add a quick setting tile or button for easy access.",
  ),
];
