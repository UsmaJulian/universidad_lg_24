import 'package:flutter/material.dart';

class FlutterRadioButtonFormField extends FormField<dynamic> {
  FlutterRadioButtonFormField({
    required this.data,
    required this.value,
    required this.display,
    required BuildContext context,
    super.key,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.tileColor,
    this.selectedTileColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autoFocus = false,
    this.shape,
    this.padding,
    super.onSaved,
    super.validator,
    bool autoValidate = false,
    this.titleStyle,
  }) : super(
          builder: (FormFieldState<dynamic> state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                padding: padding,
                shrinkWrap: true,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio(
                      value: data[index][value],
                      groupValue: state.value,
                      activeColor: activeColor,
                      autofocus: autoFocus!,
                      focusColor: focusColor,
                      focusNode: focusNode,
                      hoverColor: hoverColor,
                      materialTapTargetSize: materialTapTargetSize,
                      mouseCursor: mouseCursor,
                      onChanged: (value) {
                        state.didChange(value);
                      },
                      toggleable: toggleable!,
                      visualDensity: visualDensity,
                    ),
                    title: Text(
                      data[index][display].toString(),
                      style: titleStyle ?? const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      if (toggleable == true) {
                        if (state.value != data[index][value]) {
                          state.didChange(data[index][value]);
                        } else {
                          state.didChange(null);
                        }
                      } else {
                        state.didChange(data[index][value]);
                      }
                    },
                  );
                },
              ),
            );
          },
        );

  final List<Map<dynamic, dynamic>> data;

  final String value;

  final String display;

  final MouseCursor? mouseCursor;

  final bool? toggleable;

  final Color? activeColor;

  final Color? focusColor;

  final Color? hoverColor;
  final Color? tileColor;

  final Color? selectedTileColor;

  final MaterialTapTargetSize? materialTapTargetSize;

  final VisualDensity? visualDensity;

  final FocusNode? focusNode;

  final bool? autoFocus;

  final TextStyle? titleStyle;

  final ShapeBorder? shape;

  final EdgeInsetsGeometry? padding;
}
