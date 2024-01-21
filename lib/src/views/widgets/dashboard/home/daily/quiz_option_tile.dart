import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';

class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    required this.onSelectOption,
    required this.optionText,
    required this.isSelected,
    super.key,
  });

  final GestureTapCallback onSelectOption;
  final String optionText;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onClick: onSelectOption,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: !isSelected ? ColorName.brightGrey : white),
          borderRadius: BorderRadius.circular(context.dx(8.0)),
          color: isSelected ? ColorName.oceanGreen : white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.dx(12.0),
          vertical: context.dy(14.0),
        ),
        child: Row(
          children: [
            (isSelected
                    ? Assets.graphics.circularCheckboxChecked
                    : Assets.graphics.circularCheckboxUnchecked)
                .svg(
              height: context.dx(20.0),
              width: context.dx(20.0),
              fit: BoxFit.cover,
            ),
            const Space.horizontal(8.0),
            Expanded(
              child: Text(optionText, style: context.textStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}
