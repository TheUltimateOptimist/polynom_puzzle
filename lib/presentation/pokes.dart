import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/blocs/user_state.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
class Pokes extends BlocBuilder<UserCubit, UserState> {
  static double textSize = 20;
  static  double spaceBetween = 5;

  Pokes(
    {
    final bool isWhite = false,final String? trophyCount,final double multiplier = 1,
  }) : super(
          builder: (context, state) {
            return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: multiplier*textSize / 3,
                  ),
                  child: isWhite
                      ? WhiteBoldText(
                          fontSize: multiplier*textSize,
                          text: trophyCount == null ? state.user.trophyCount.toString() : trophyCount,
                        )
                      : BlackBoldText(
                          fontSize: multiplier*textSize,
                          text: trophyCount == null ? state.user.trophyCount.toString() : trophyCount,
                        ),
                ),
                Container(
                  width: spaceBetween,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: multiplier*textSize / 5,
                  ),
                  width: multiplier*textSize,
                  height: multiplier*textSize,
                  child: SvgPicture.asset(
                    "assets/pictures/poke.svg",
                  ),
                ),
              ],
            );
          },
        );
}
