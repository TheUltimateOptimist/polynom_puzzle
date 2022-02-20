import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const ActionButton({required this.child, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: FunctionColors.one,
        fixedSize: const Size(
          150,
          60,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
      ),
      child: child,
    );
  }
}
