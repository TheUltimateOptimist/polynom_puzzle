import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/register_login_layout.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  static const double borderRadius = 15;
  static const double aroundMargin = 30;
  static const double titleFontSize = 50;
  static const double subTitleFontSize = 30;

  @override
  Widget build(BuildContext context) {
    Sizes.update(context);
    print(MediaQuery.of(context).size.width);
    if (!Sizes.onMobile) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 450,
                  height: 650,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Polynom Puzzle",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: FunctionColors.one,
                          fontFamily: "Noteworthy-Bold",
                        ),
                      ),
                      BlackBoldText(
                        fontSize: subTitleFontSize,
                        text: "better way to learn math",
                      ),
                      SizedBox(
                        height: 300,
                        child: SvgPicture.asset("assets/pictures/tafel.svg"),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height: 650,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffedf2ef),
                          blurRadius: 15,
                          spreadRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(
                      borderRadius,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: aroundMargin,
                    ),
                    child: RegisterLoginLayout(
                      isRegister: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            scrollDirection: Axis.vertical,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Polynom Puzzle",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: FunctionColors.one,
                            fontFamily: "Noteworthy-Bold",
                          ),
                        ),
                        BlackBoldText(
                          fontSize: subTitleFontSize,
                          text: "better way to learn math",
                        ),
                        SizedBox(
                          height: 300,
                          child: SvgPicture.asset("assets/pictures/tafel.svg"),
                        ),
                      
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_rounded, color: Colors.black, size: 50,),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                    width: Sizes.onMobile ? Sizes.totalWidth : 450,
                    height: Sizes.onMobile ? Sizes.totalHeight : 650,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffedf2ef),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(
                        borderRadius,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: aroundMargin,
                      ),
                      child: RegisterLoginLayout(
                        isRegister: true,
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
