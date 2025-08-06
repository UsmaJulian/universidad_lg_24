// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Resuelvelo/loading_bloc/loading_bloc.dart';
import 'package:universidad_lg_24/constants.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({
    this.onPress,
    super.key,
    this.text,
    this.bgColor = mainColor,
    this.textColor = Colors.white,
    this.routeName,
  });
  final String? text;
  Widget? onPress;
  final String? routeName;
  Color bgColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(140, 40),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            backgroundColor: bgColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          onPressed: (onPress != null && routeName != null)
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return onPress!;
                      },
                      settings: RouteSettings(name: routeName),
                    ),
                  );
                }
              : null,
          child: (state.isLoading ==
                  false) // ✅ Verifica si isLoading es false o null
              ? (onPress != null && text != null)
                  ? Text(text!, style: TextStyle(color: textColor))
                  : Text(
                      text ?? 'Proximamente',
                      style: const TextStyle(color: mainColor),
                    )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
