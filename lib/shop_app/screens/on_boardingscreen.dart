// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, implementation_imports, unnecessary_string_interpolations, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:api_projects/shared/components/components.dart';
import 'package:api_projects/shop_app/screens/shop_login.dart';
import 'package:api_projects/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  //final String body;

  BoardingModel({required this.image, required this.title, });//required this.body
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image:
          'https://cdn-icons-png.flaticon.com/512/8663/8663631.png',
      title: 'Online Shopping',
      //body: 'On Board 1 Body',
    ),
    BoardingModel(
      image:
          'https://cdn-icons-png.flaticon.com/512/8730/8730692.png',
      title: "Don't forget to check offers",
      //body: 'On Board 2 Body',
    ),
    BoardingModel(
      image:
          'https://cdn-icons-png.flaticon.com/512/7360/7360313.png',
      title: 'Start your favourite shopping',
      //body: 'On Board 3 Body',
    ),
  ];

  var boardcontroller = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submit();
            },
             text: 'SKIP',),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: ((context, index) =>
                    buildBoardingItem(boarding[index])),
                controller: boardcontroller,
                onPageChanged: ((int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;                    
                    });
                  }
                }),
                physics: BouncingScrollPhysics(),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardcontroller.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // Text(
          //   '${model.body}',
          //   style: TextStyle(
          //     fontSize: 14,
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
        ],
      );


 void submit (){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if(value){
        navigateAndFinish(context, ShopLogin());
    }
  });
 }
}
