import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/base_dialog.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:polynom_puzzle/presentation/with_friend_dialog.dart';

import '../logic/models/game.dart';

class FindingOpponentDialog extends StatefulWidget {
  final int difficulty;
  final bool isFriend;
  final int? gameId;
  const FindingOpponentDialog(
      {Key? key, required this.difficulty, this.isFriend = false, this.gameId})
      : super(key: key);

  @override
  State<FindingOpponentDialog> createState() => _FindingOpponentDialogState();
}

class _FindingOpponentDialogState extends State<FindingOpponentDialog> {
  Game? game;
  int? generatedGameId;
  Timer? t;

  @override
  void initState() {
    if (widget.isFriend && widget.gameId == null) {
      generatedGameId = Game.generateId();
    }
    initGame();
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      if (game != null && mounted) {
        Navigator.pop(context, game);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisSize: MainAxisSize.min,
                children: [
                  BlackBoldText(
                    fontSize: 25,
                    text: "Finding Opponent...",
                  ),
                  if (generatedGameId != null)
                  Container(
                  height: 10,
                ),
                if (generatedGameId != null)
                  SelectableText(
                 
                  "GameId: " + generatedGameId.toString(),
                  style: BlackText.style(15,),
                ),
                ],
              ),
            ],
          ),
          CircularProgressIndicator(
            color: Colors.black,
          ),
          SelectButton(
            title: "Cancel",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Future<void> initGame() async {
    if (widget.isFriend && widget.gameId != null) {
      game = await Game.withFriend(widget.difficulty, widget.gameId!, false);
    } else if (widget.isFriend) {
      game = await Game.withFriend(widget.difficulty, generatedGameId!, true);
    } else if (!widget.isFriend) {
      game = await Game.multiPlayer(widget.difficulty);
    }
  }
}
