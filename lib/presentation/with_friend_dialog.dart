import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/base_dialog.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/input_field.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

class WithFriendDialog extends StatelessWidget {
  WithFriendDialog({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      additionalMargin: 50,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlackBoldText(fontSize: 30, text: "Play with Friend"),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlackText(fontSize: 20, text: "GameId: "),
              Container(
                height: 10,
              ),
              InputField(
                hintText: "Enter gameId to join game",
                textEditingController: controller,
              ),
            ],
          ),
          BlackText(
            fontSize: 15,
            text:
                "You can enter a GameId to join a game or select New Game. If you select New Game you will be given a GameId your friend needs to enter to join you.",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectButton(
                title: "Join Game",
                onPressed: () {
                  if(controller.text.length == 0){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a GameId first")));
                  }
                  else if(controller.text.length != 8){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("A proper GameId consists of 8 numbers")));
                  }
                  else{
                    try{
                      int gameId = int.parse(controller.text);
                      Navigator.pop(context, {"gameId": gameId});
                    }
                    catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GameId is invalid")));
                    }
                  }
                },
              ),
              // Container(width: 20,),
              SelectButton(
                title: "New Game",
                onPressed: () {
                  Navigator.pop(context, {"gameId": null});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectButton extends ElevatedButton {
  SelectButton(
      {required final String title, required final void Function() onPressed})
      : super(
          onPressed: onPressed,
          child: WhiteBoldText(
            fontSize: 25,
            text: title,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            minimumSize: Size(
              150,
              65,
            ),
          ),
        );
}
