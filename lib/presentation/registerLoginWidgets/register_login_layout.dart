import 'package:flutter/material.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/big_black_button.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/google_button.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/input_field.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/small_black_button.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterLoginLayout extends StatefulWidget {
  RegisterLoginLayout({required this.isRegister, Key? key}) : super(key: key);

  static double titleFontSize = 25;
  static double secondTextSize = 20;
  bool isRegister;

  @override
  State<RegisterLoginLayout> createState() => _RegisterLoginLayoutState();
}

class _RegisterLoginLayoutState extends State<RegisterLoginLayout> {
  final TextEditingController emailEditingController = TextEditingController();

  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlackBoldText(
              fontSize: RegisterLoginLayout.titleFontSize,
              text: widget.isRegister ? "Register" : "Login",
            ),
            SmallBlackButton(
              onPressed: () async{
                await context.read<UserCubit>().loginAsGuest();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Lobby()));
              },
              title: "Play as guest",
            ),
          ],
        ),
          InputField(
            hintText: "E-Mail",
            textEditingController: emailEditingController,
          ),
          if (widget.isRegister)
        InputField(
          hintText: "Username",
          textEditingController: nameEditingController,
        ),
        InputField(
          hintText: "Password",
          textEditingController: passwordEditingController,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BigBlackButton(
              onPressed: () async{
                UserCubit userCubit = context.read<UserCubit>();
                if(widget.isRegister){
                await userCubit.register(emailEditingController.text, nameEditingController.text, passwordEditingController.text,);
              }
              else{
                await userCubit.login(emailEditingController.text, passwordEditingController.text);
              }
                Navigator.push(context, MaterialPageRoute(builder: (context) => Lobby()));
              },
              title: widget.isRegister ? "Register now" : "Login",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlackText(
                    fontSize: RegisterLoginLayout.secondTextSize,
                    text: widget.isRegister
                        ? "Already have an account? "
                        : "Don't have an account? "),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.isRegister = widget.isRegister ? false : true;
                    });
                  },
                  child: BlackText(
                    fontSize: RegisterLoginLayout.secondTextSize,
                    isUnderlined: true,
                    text: widget.isRegister ? "Login" : "Register",
                  ),
                )
              ],
            ),
          ],
        ),
        BlackText(
          text: "or",
          fontSize: RegisterLoginLayout.secondTextSize,
        ),
        GoogleButton(() {Navigator.push(context, MaterialPageRoute(builder: (context) => Lobby()));})
      ],
    );
  }
}
