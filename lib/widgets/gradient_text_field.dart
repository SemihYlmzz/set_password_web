import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:set_new_password/constants/text_styles.dart';

import '../constants/colors.dart';
import '../constants/linear_gradients.dart';

class GradientTextField extends StatefulWidget {
  final double? width;
  final bool readOnly;
  final int? maxLines;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String hintText;
  final bool isDateOfBirthTextField;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  const GradientTextField({
    super.key,
    this.width,
    this.readOnly = false,
    this.maxLines,
    this.onSubmitted,
    this.obscureText = false,
    this.isDateOfBirthTextField = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.validator,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  State<GradientTextField> createState() => _GradientTextFieldState();
}

class _GradientTextFieldState extends State<GradientTextField> {
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  String tarihDuzelt(String tarih) {
    List<String> parcalar = tarih.split('-');
    String gun = '';
    String ay = '';
    String yil = '';

    // Günü düzeltme
    if (parcalar.isNotEmpty) {
      gun = parcalar[0];
      if (gun.length == 2) {
        int gunInt = int.parse(gun);
        if (gunInt < 1) {
          gun = '01';
        } else if (gunInt > 31) {
          gun = '31';
        }
      }
    }

    // Ayı düzeltme
    if (parcalar.length > 1) {
      ay = parcalar[1];
      if (ay.length == 2) {
        int ayInt = int.parse(ay);
        if (ayInt < 1) {
          ay = '01';
        } else if (ayInt > 12) {
          ay = '12';
        }
      }
    }

    // Yıl
    if (parcalar.length > 2) {
      yil = parcalar[2];
    }

    return '$gun${ay.isNotEmpty ? '-' : ''}$ay${yil.isNotEmpty ? '-' : ''}$yil';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextFormField(
          style: const TextStyle(
            color: Colors.white,
          ),
          inputFormatters: [
            if (widget.isDateOfBirthTextField)
              MultiMaskedTextInputFormatter(
                  masks: ['xx-xx-xxxx'], separator: '-')
          ],
          maxLines: widget.maxLines ?? 1,
          autofocus: false,
          obscureText: obscureText,
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            suffixIcon:
                (widget.obscureText && widget.textEditingController.text != '')
                    ? GestureDetector(
                        onTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        child: Container(
                          width: 70,
                          color: Colors.transparent,
                          child: Icon(
                            Icons.visibility,
                            color: AppColors.white.shade500,
                          ),
                        ),
                      )
                    : Container(width: 1),
            labelStyle: AppTextStyles.labelLarge.copyWith(
              color: AppColors.white,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            alignLabelWithHint: true,
            labelText: widget.hintText,
            hintText: widget.isDateOfBirthTextField ? 'DD-MM-YYYY' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.white.shade025,
                width: 1,
              ),
            ),
            focusedBorder: const GradientOutlineInputBorder(
              gradient: AppLinearGradients.orangeDefault,
              width: 2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.negativeRed.shade800,
                width: 1,
              ),
            ),
            focusedErrorBorder: const GradientOutlineInputBorder(
              gradient: AppLinearGradients.orangeDefault,
              width: 2,
            ),
          ),
          focusNode: widget.focusNode,
          enableSuggestions: false,
          onChanged: (String newValue) {
            if (widget.isDateOfBirthTextField) {
              final String newText = tarihDuzelt(newValue);

              // Yeni değeri atamadan önce imleç pozisyonunu kaydedin.
              final int oldCursorPosition =
                  widget.textEditingController.selection.start;
              final int oldTextLength =
                  widget.textEditingController.text.length;

              // Yeni değeri atayın ve imleç pozisyonunu güncelleyin.
              widget.textEditingController.value = TextEditingValue(
                text: newText,
                selection: TextSelection.collapsed(
                  offset: oldCursorPosition + (newText.length - oldTextLength),
                ),
              );
            }
            setState(() {});
          },
          validator: widget.validator,
          readOnly: widget.readOnly,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
