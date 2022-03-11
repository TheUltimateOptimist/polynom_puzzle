import 'package:flutter/material.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/blocs/user_state.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/presentation/container_content.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/ranking.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
import 'package:polynom_puzzle/presentation/top_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../function_colors.dart';
import '../logic/models/stats.dart';
import 'Widgets/white_text.dart';
import 'colored_container.dart';

abstract class StatsTitles {
  static const overallGamesPlayed = "Overall Games played: ";
  static const overallGamesWon = "Overall Games won: ";
  static const overallGameLost = "Overall Games lost: ";

  static const gamesPlayed = "Games played: ";
  static const gamesWon = "Games won: ";
  static const gamesLost = "Games lost: ";
}

class Profile extends StatelessWidget {
  final Stats? stats;
  final int? rank;
  final String? name;
  const Profile({this.stats,this.rank,this.name,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: Lobby.pageWidth,
            height: Lobby.pageHeight,
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: rank == null ? BackEnd().getRank(state.user.trophyCount) : Future.value(rank),
                        builder: ((context, snapshot) {
                          String text = "...";
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            text = ": #" + snapshot.data.toString();
                          }
                          return TopRow(
                            firstPressed: () async {
                              await context.read<UserCubit>().logout();
                              Navigator.popUntil(
                                  context, ModalRoute.withName("/login"));
                            },
                            secondPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Ranking()));
                            },
                            title: name ?? state.user.name,
                            first: stats == null ? "Logout" : "",
                            second: "Rank" + text,
                          );
                        })),
                    Row(
                      children: [
                        StatItem(
                          StatsTitles.overallGamesPlayed,
                          stats?.overallGamesPlayed ??  state.user.stats.overallGamesPlayed,
                          onContainer: false,
                        ),
                        StatItem(
                          StatsTitles.overallGamesWon,
                          stats?.overallGamesWon ?? state.user.stats.overallGamesWon,
                          onContainer: false,
                        ),
                        StatItem(
                          StatsTitles.overallGameLost,
                          stats?.overallGamesLost ?? state.user.stats.overallGamesLost,
                          onContainer: false,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Row(
                      children: [
                        ColoredContainer(
                          FunctionColors.two,
                          ignorePointer: true,
                          child: ModeContent(
                            Difficultie.linear,
                            values: [
                              stats?.linearGamesPlayed ?? state.user.stats.linearGamesPlayed,
                              stats?.linearGamesWon ?? state.user.stats.linearGamesWon,
                              stats?.linearGamesLost ?? state.user.stats.linearGamesLost,
                            ],
                          ),
                          onPressed: () {},
                        ),
                        ColoredContainer(
                          FunctionColors.one,
                          ignorePointer: true,
                          child: ModeContent(
                            Difficultie.quadratic,
                            values: [
                              stats?.quadraticGamesPlayed ?? state.user.stats.quadraticGamesPlayed,
                              stats?.quadraticGamesWon ?? state.user.stats.quadraticGamesWon,
                              stats?.quadraticGamesLost ?? state.user.stats.quadraticGamesLost,
                            ],
                          ),
                          onPressed: () {},
                        ),
                        ColoredContainer(
                          FunctionColors.three,
                          ignorePointer: true,
                          child: ModeContent(
                            Difficultie.cubic,
                            values: [
                              stats?.cubicGamesPlayed ?? state.user.stats.cubicGamesPlayed,
                              stats?.cubicGamesWon ?? state.user.stats.cubicGamesWon,
                              stats?.cubicGamesLost ?? state.user.stats.cubicGamesLost,
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class StatItem extends Row {
  StatItem(
    final String title,
    final int count, {
    final bool onContainer = true,
  }) : super(
          children: [
            if (onContainer)
              WhiteText(
                fontSize: Lobby.subtitleFontSize,
                title: title,
              )
            else
              BlackText(fontSize: Lobby.subtitleFontSize, text: title),
            Container(
              width: Lobby.subtitleFontSize * 0.5,
            ),
            if (onContainer)
              Container(
                margin: EdgeInsets.only(
                  top: Lobby.subtitleFontSize * 0.4,
                ),
                child: WhiteBoldText(
                  fontSize: Lobby.subtitleFontSize,
                  text: count.toString(),
                ),
              )
            else
              Container(
                margin: EdgeInsets.only(
                  top: Lobby.subtitleFontSize * 0.4,
                ),
                child: BlackBoldText(
                  fontSize: Lobby.subtitleFontSize,
                  text: count.toString(),
                ),
              ),
          ],
          mainAxisAlignment: onContainer
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          mainAxisSize: onContainer ? MainAxisSize.max : MainAxisSize.min,
        );
}

class ModeContent extends ContainerContent {
  ModeContent(
    final String title, {
    final List<int> values = const [
      100,
      99,
      3450,
    ],
  }) : super(
          title,
          children: [
            StatItem(
              StatsTitles.gamesPlayed,
              values[0],
            ),
            StatItem(
              StatsTitles.gamesWon,
              values[1],
            ),
            StatItem(
              StatsTitles.gamesLost,
              values[2],
            ),
          ],
        );
}
