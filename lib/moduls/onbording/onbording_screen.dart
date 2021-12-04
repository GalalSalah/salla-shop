import 'package:app_shop/moduls/auth/login_screen.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:app_shop/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({@required this.body, @required this.title, @required this.image});
}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_11.jpg', body: 'Communicate with us to hot offer', title: 'Salla Shop'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg', body: 'Enything is here', title: 'Salla Shop'),
    BoardingModel(
        image: 'assets/images/onboard_13.jpg', body: 'Sign up to hot offer', title: 'Salla Shop'),
  ];
void submit(){
  CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if(value){
      navigateTo(context,  LoginScreen());
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // defaultTextButton(fct: fct, label: label)
          defaultTextButton(
              fct: () => submit(),
              label: 'Skip'),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, i) => onBoardingItem(boarding[i]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 2,
                    activeDotColor: defaultColor,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child:isLast?const Icon(Icons.check,color: Colors.white
                    ,): const Icon(Icons.arrow_forward_ios,color:Colors.white,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          // SizedBox(height: 30,),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      );
}
