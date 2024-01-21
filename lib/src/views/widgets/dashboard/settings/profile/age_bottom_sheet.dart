import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/big_button.dart';
import '../../../common/space.dart';

class AgeBottomSheet extends ConsumerStatefulWidget {
  const AgeBottomSheet({super.key});

  @override
  ConsumerState<AgeBottomSheet> createState() => _AgeBottomSheetState();
}

class _AgeBottomSheetState extends ConsumerState<AgeBottomSheet> {
  String get _formattedDateOfBirth =>
      DateTime(_yearOfBirth, _monthOfYear, _dayOfMonth).asYyMmDd;

  int get _daysInMonth => DateTime(_yearOfBirth, _monthOfYear + 1, 0).day;

  late final _dateOfBirth = ref.read(authViewModel).currentUser.dateOfBirth;

  late final _localizations = context.l10n;

  late var _yearOfBirth =
      _dateOfBirth.isNotEmpty ? int.parse(_dateOfBirth.split('-')[0]) : 2000;

  late var _monthOfYear =
      _dateOfBirth.isNotEmpty ? int.parse(_dateOfBirth.split('-')[1]) : 1;

  late var _dayOfMonth =
      _dateOfBirth.isNotEmpty ? int.parse(_dateOfBirth.split('-')[2]) : 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: context.dy(16.0)),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.brightGrey)),
            ),
            alignment: Alignment.center,
            child: Text(
              _localizations.dateOfBirth,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
            child: Column(
              children: [
                const Space.vertical(40.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: ColorName.brightGrey),
                          ),
                        ),
                        child: DropdownButton<int>(
                          padding:
                              EdgeInsets.symmetric(vertical: context.dy(8.0)),
                          underline: const SizedBox.shrink(),
                          onChanged: (value) {
                            setState(() => _dayOfMonth = value!);
                          },
                          icon: Assets.graphics.downChevron.svg(
                            height: context.dx(16.0),
                            width: context.dx(16.0),
                            fit: BoxFit.cover,
                          ),
                          value: _dayOfMonth,
                          dropdownColor: white,
                          isExpanded: true,
                          isDense: true,
                          items: [
                            for (var dayOfMonth = 1;
                                dayOfMonth <= _daysInMonth;
                                dayOfMonth++)
                              DropdownMenuItem(
                                value: dayOfMonth,
                                child: Center(
                                  child: Text(
                                    '$dayOfMonth'.padLeft(2, '0'),
                                    style: context.textStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Space.horizontal(8.0),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: ColorName.brightGrey),
                          ),
                        ),
                        child: DropdownButton<int>(
                          padding:
                              EdgeInsets.symmetric(vertical: context.dy(8.0)),
                          underline: const SizedBox.shrink(),
                          onChanged: (value) =>
                              setState(() => _monthOfYear = value!),
                          icon: Assets.graphics.downChevron.svg(
                            height: context.dx(16.0),
                            width: context.dx(16.0),
                            fit: BoxFit.cover,
                          ),
                          value: _monthOfYear,
                          dropdownColor: white,
                          isExpanded: true,
                          isDense: true,
                          items: [
                            for (var monthOfYear = 1;
                                monthOfYear <= 12;
                                monthOfYear++)
                              DropdownMenuItem(
                                value: monthOfYear,
                                child: Center(
                                  child: Text(
                                    _localizations.monthsOfTheYear
                                        .split('|')[monthOfYear - 1],
                                    style: context.textStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Space.horizontal(8.0),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: ColorName.brightGrey),
                          ),
                        ),
                        child: DropdownButton<int>(
                          padding:
                              EdgeInsets.symmetric(vertical: context.dy(8.0)),
                          underline: const SizedBox.shrink(),
                          onChanged: (value) =>
                              setState(() => _yearOfBirth = value!),
                          icon: Assets.graphics.downChevron.svg(
                            height: context.dx(16.0),
                            width: context.dx(16.0),
                            fit: BoxFit.cover,
                          ),
                          value: _yearOfBirth,
                          dropdownColor: white,
                          isExpanded: true,
                          isDense: true,
                          items: [
                            for (var yearOfBirth = 1900;
                                yearOfBirth <= DateTime.now().year - 3;
                                yearOfBirth++)
                              DropdownMenuItem(
                                value: yearOfBirth,
                                child: Center(
                                  child: Text(
                                    '$yearOfBirth',
                                    style: context.textStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Space.vertical(40.0),
                BigButton(
                  labelText: _localizations.save,
                  onPressed: () {
                    context.pop();
                    ref.read(authViewModel.notifier).update(
                          currentUser: ref
                              .read(authViewModel)
                              .currentUser
                              .copyWith(dateOfBirth: _formattedDateOfBirth),
                        );
                  },
                ),
                const Space.vertical(16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
