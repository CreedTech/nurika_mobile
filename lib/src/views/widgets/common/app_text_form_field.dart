import 'package:flutter/material.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';
import 'space.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.onToggleVisibility,
    this.shouldObscureText,
    this.textInputAction,
    this.keyboardType,
    this.initialValue,
    this.maxLength,
    this.isEnabled,
    this.validator,
    this.labelText,
    this.hintText,
    super.key,
  });

  final FormFieldValidator<String>? validator;

  final VoidCallback? onToggleVisibility;

  final TextInputAction? textInputAction;

  final TextInputType? keyboardType;

  final String? initialValue;
  final String? labelText;
  final String? hintText;

  final bool? shouldObscureText;
  final bool? isEnabled;

  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$labelText',
          style: context.textStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        const Space.vertical(8.0),
        TextFormField(
          style: context.textStyle(fontSize: 16.0),
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            errorStyle: context.textStyle(colour: ColorName.carminePink),
            contentPadding: EdgeInsets.symmetric(vertical: context.dy(8.0)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorName.chineseBlack),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorName.lightSilver),
            ),
            suffixIcon: shouldObscureText != null
                ? IconButton(
                    icon: Icon(
                      shouldObscureText!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorName.lavenderGrey,
                      size: context.dx(16.0),
                    ),
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: onToggleVisibility,
                    padding: EdgeInsets.zero,
                  )
                : null,
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorName.carminePink),
            ),
            hintStyle: context.textStyle(
              colour: ColorName.manatee,
              fontSize: 16.0,
            ),
            hintText: hintText,
          ),
          enabled: isEnabled ?? true,
          obscureText: shouldObscureText ?? false,
          cursorColor: ColorName.chineseBlack,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          initialValue: initialValue,
          maxLength: maxLength,
          validator: validator,
        ),
      ],
    );
  }
}
