import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/blocs/user_state.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/logic/models/stats.dart';
import 'package:polynom_puzzle/presentation/colored_container.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/profile.dart';
import 'package:polynom_puzzle/presentation/puzzle_navigation_bar.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/wihte_text.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

  static const double entryHeight = 60;
  static const double aroundMargin = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(bottomNavigationBar: Sizes.onMobile ? PuzzleNavigationBar(index: 2) : null,
        body: Container(
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.95,
          ),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return FutureBuilder(
                future: BackEnd().getRankList(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount:
                          (snapshot.data as List<Map<String, dynamic>>).length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> map = (snapshot.data
                            as List<Map<String, dynamic>>)[index];
                        int rank = index + 1;
                        late Color color;
                        switch (rank) {
                          case 1:
                            color = FunctionColors.one;
                            break;
                          case 2:
                            color = FunctionColors.two;
                            break;
                          case 3:
                            color = FunctionColors.three;
                            break;
                          default:
                            color = Colors.black;
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: aroundMargin,
                          ),
                          height: entryHeight,
                          width: MediaQuery.of(context).size.width,
                          child: PlayerEntry(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(
                                    rank: map["rank"],name: map["name"],
                                    stats: Stats.fromMap(
                                      map["stats"],
                                    ),
                                  ),
                                ),
                              );
                            },
                            color: color,
                            isCurrentUser: map["isCurrentUser"],
                            ranking: map["rank"],
                            playerName: map["name"],
                            trophyCount: map["trophyCount"],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: WhiteBoldText(
                        fontSize: 25,
                        text: "Loading...",
                      ),
                    );
                  }
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PlayerEntry extends ElevatedButton {
  PlayerEntry({
    required final bool isCurrentUser,
    required final void Function() onPressed,
    final int ranking = 34,
    final String playerName = "Hans Kans",
    final int trophyCount = 1345,
    required final Color color,
  }) : super(
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isCurrentUser ? Colors.white : Colors.transparent,
                width: isCurrentUser ? 4 : 0,
              ),
              borderRadius: BorderRadius.circular(
                ColoredContainer.cornerRadius * 0.7,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Pokes.textSize * 0.29,
                    ),
                    child: WhiteBoldText(
                      fontSize: Pokes.textSize,
                      text: "#" + ranking.toString(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 50,
                    ),
                    child: WhiteText(
                      fontSize: Pokes.textSize,
                      text: isCurrentUser ? "You" : playerName,
                    ),
                  ),
                ],
              ),
              Pokes(
                trophyCount: trophyCount.toString(),
                isWhite: true,
              ),
            ],
          ),
        );
}
