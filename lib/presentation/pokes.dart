import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/blocs/user_state.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

class Pokes extends BlocBuilder<UserCubit, UserState> {
  static const double textSize = 20;
  static const double spaceBetween = 5;

  Pokes(
    {
    final bool isWhite = false,final int? trophyCount,
  }) : super(
          builder: (context, state) {
            return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: textSize / 3,
                  ),
                  child: isWhite
                      ? WhiteBoldText(
                          fontSize: textSize,
                          text: trophyCount == null ? state.user.trophyCount.toString() : trophyCount.toString(),
                        )
                      : BlackBoldText(
                          fontSize: textSize,
                          text: state.user.trophyCount.toString(),
                        ),
                ),
                Container(
                  width: spaceBetween,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: textSize / 5,
                  ),
                  width: textSize,
                  height: textSize,
                  child: SvgPicture.asset(
                    "assets/pictures/poke.svg",
                  ),
                ),
              ],
            );
          },
        );
}
