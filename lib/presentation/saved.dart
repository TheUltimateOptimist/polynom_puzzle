// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:polynom_puzzle/function_colors.dart';
// import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
// import 'package:polynom_puzzle/logic/blocs/user_state.dart';
// import 'package:polynom_puzzle/logic/models/game.dart';
// import 'package:polynom_puzzle/logic/models/user.dart';
// import 'package:polynom_puzzle/presentation/colored_container.dart';
// import 'package:polynom_puzzle/presentation/finding_opponent_dialog.dart';
// import 'package:polynom_puzzle/presentation/playing.dart';
// import 'package:polynom_puzzle/presentation/profile.dart';
// import 'package:polynom_puzzle/presentation/ranking.dart';
// import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
// import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
// import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
// import 'package:polynom_puzzle/presentation/top_row.dart';
// import 'package:polynom_puzzle/presentation/with_friend_dialog.dart';

// import '../constants/sizes.dart';
// import 'container_content.dart';

// abstract class Modes {
//   static const String singlePlayer = "SinglePlayer";
//   static const String multiPlayer = "MultiPlayer";
//   static const String withFriend = "Play with friend";
// }

// abstract class Difficulty {
//   static const String linear = "linear";
//   static const String quadratic = "quadratic";
//   static const String cubic = "cubic";

//   static int fromString(String difficulty) {
//     switch (difficulty) {
//       case "linear":
//         return 1;
//       case "quadratic":
//         return 2;
//       case "cubic":
//         return 3;
//       default:
//         throw Exception(
//             "Error: difficulty could not be resolved from reference");
//     }
//   }
// }

// // ignore: must_be_immutable
// class Lobby extends StatelessWidget {
//   Lobby({Key? key}) : super(key: key);

//   static const double subtitleFontSize = 20;
//   static const double categoryFontSize = 30;
//   static const double difficultyFontSize = 20;
//   static const double pageWidth = 1000;
//   static const double pageHeight = 600;
//   static const double menuSize = 30;
//   @override
//   Widget build(BuildContext context) {
//     print(MediaQuery.of(context).size.width);
//     Sizes.update(context);
//     return SafeArea(
//       child: Scaffold(
      
        
//         backgroundColor: Colors.white,
//         appBar: Sizes.onMobile
//             ? AppBar(centerTitle: true,
//                 iconTheme: IconThemeData(
//                   color: Colors.black,
//                   size: menuSize,
//                 ),
//                 foregroundColor: Colors.black,
//                 titleSpacing: 0.0,
//                 leadingWidth: menuSize * 2,
//                 toolbarHeight: 70,
//                 elevation: 0,
//                 backgroundColor: Colors.white,
//                 title: BlackBoldText(
//                   fontSize: 35,
//                   text: "Polynom Puzzle",
//                 ),
//               )
//             : null,
//         body: Center(
//           child: Container(
//             width: !Sizes.onMobile ? pageWidth * Sizes.multiplierLight : Sizes.totalWidth - 40,
//             height: !Sizes.onMobile ? pageHeight : double.infinity,
//             child: Column(
//               crossAxisAlignment: !Sizes.onMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//               mainAxisAlignment: !Sizes.onMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceEvenly,
//               children: [if(!Sizes.onMobile)
//                 TopRow(
//                   firstPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Ranking()));
//                   },
//                   secondPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Profile()));
//                   },
//                   title: "Polynom Puzzle",
//                   first: "Rangliste",
//                   second: "My Profile",
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     BlackText(
//                       fontSize: subtitleFontSize,
//                       text:
//                           "Let's go! Prove your math skills solving the Polynom Puzzle in either",
//                     ),
//                     BlackText(
//                       fontSize: subtitleFontSize,
//                       text:
//                           "Single- or Multiplayer Mode. Or challenge a friend. Just Have fun!",
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: double.infinity,height: 400,
//                   child: RowColumnListView(collectionType: !Sizes.onMobile ? Collection.row : Collection.listView,
//                     children: [
//                       ColoredContainer(
//                         FunctionColors.two,
//                         child: ModeContent(
//                           Modes.singlePlayer,
//                         ),
//                         onPressed: () {
//                           Game game = Game.singlePlayer(1);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Playing(
//                                 game: game,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       ColoredContainer(
//                         FunctionColors.one,
//                         child: ModeContent(
//                           Modes.multiPlayer,
//                         ),
//                         onPressed: () async {
//                           Game? result = await showDialog(
//                             context: context,
//                             builder: (context) => FindingOpponentDialog(
//                               difficulty: Difficulty.fromString(
//                                 PuzzleUser().multiPlayerDifficulty,
//                               ),
//                             ),
//                           );
//                           print(result);
//                           if (result != null) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Playing(game: result),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       ColoredContainer(
//                         FunctionColors.three,
//                         child: ModeContent(
//                           Modes.withFriend,
//                         ),
//                         onPressed: () async {
//                           Map<String, int?>? data = await showDialog(
//                             context: context,
//                             builder: (context) => WithFriendDialog(),
//                           );
//                           if (data != null) {
//                             Game? game = await showDialog(
//                               context: context,
//                               builder: (context) => FindingOpponentDialog(
//                                 difficulty: Difficulty.fromString(
//                                   PuzzleUser().withFriendDifficulty,
//                                 ),
//                                 isFriend: true,
//                                 gameId: data["gameId"],
//                               ),
//                             );
//                             if (game != null) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Playing(
//                                     game: game,
//                                   ),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                       ),
//                     ],
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ModeContent extends ContainerContent {
//   ModeContent(final String title)
//       : super(
//           title,
//           children: [
//             SelectionRow(
//               mode: title,
//               title: Difficulty.linear,
//             ),
//             SelectionRow(
//               mode: title,
//               title: Difficulty.quadratic,
//             ),
//             SelectionRow(
//               mode: title,
//               title: Difficulty.cubic,
//             ),
//           ],
//         );
// }

// class Selecter extends Stack {
//   Selecter({
//     final bool isSelected = false,
//   }) : super(
//           alignment: Alignment.center,
//           children: [
//             Icon(
//               Icons.circle,
//               size: Lobby.difficultyFontSize,
//               color: Colors.white,
//             ),
//             if (isSelected)
//               Transform.rotate(
//                 angle: pi / 4,
//                 child: Icon(
//                   Icons.add,
//                   size: Lobby.difficultyFontSize * 1,
//                   color: Colors.black,
//                 ),
//               ),
//           ],
//         );
// }

// class SelectionRow extends StatelessWidget {
//   final String title;
//   final String mode;

//   SelectionRow({
//     required this.mode,
//     this.title = "",
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, UserState>(
//       builder: (context, state) {
//         return Row(
//           children: [
//             TextButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(0, 0),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 0, vertical: Lobby.difficultyFontSize * 0.5),
//               ),
//               child: WhiteBoldText(
//                 fontSize: Lobby.difficultyFontSize,
//                 text: title,
//               ),
//               onPressed: () {
//                 UserCubit cubit = context.read<UserCubit>();
//                 switch (mode) {
//                   case Modes.singlePlayer:
//                     cubit.singlePlayerDifficultieSelected(title);
//                     break;
//                   case Modes.multiPlayer:
//                     cubit.multiPlayerDifficultieSelected(title);
//                     break;
//                   case Modes.withFriend:
//                     cubit.withFriendDifficultieSelected(title);
//                     break;
//                   default:
//                     throw new Exception(
//                         "ERROR: The mode could not be recognized correctly!");
//                 }
//               },
//             ),
//             if (mode == Modes.singlePlayer &&
//                 state.user.singlePlayerDifficulty == title)
//               Selecter(
//                 isSelected: true,
//               )
//             else if (mode == Modes.multiPlayer &&
//                 state.user.multiPlayerDifficulty == title)
//               Selecter(
//                 isSelected: true,
//               )
//             else if (mode == Modes.withFriend &&
//                 state.user.withFriendDifficulty == title)
//               Selecter(
//                 isSelected: true,
//               )
//             else
//               Selecter(
//                 isSelected: false,
//               ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         );
//       },
//     );
//   }
// }

// enum Collection{
//   row,column,listView
// }

// class RowColumnListView extends StatelessWidget {
//   final List<Widget>? children;
//   final MainAxisAlignment mainAxisAlignment;
//   final CrossAxisAlignment crossAxisAlignment;
//   final MainAxisSize mainAxisSize;
//   final Collection collectionType;
//   final Axis scrollDirection;
//   const RowColumnListView({required this.collectionType,this.scrollDirection = Axis.vertical,this.children,this.mainAxisAlignment = MainAxisAlignment.start,this.crossAxisAlignment = CrossAxisAlignment.center,this.mainAxisSize = MainAxisSize.max,Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if(collectionType == Collection.row){
//       return Row(children: children  ?? [], crossAxisAlignment: crossAxisAlignment,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,);
//     }
//     else if(collectionType == Collection.column){
//       return Column(children: children ?? [], crossAxisAlignment: crossAxisAlignment,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,);
//     }
//     else if(collectionType == Collection.listView){
//       return ListView(children: children ?? [],scrollDirection: scrollDirection,);
//     }
//     else throw Exception("");
//   }
// }