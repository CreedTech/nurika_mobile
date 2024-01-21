import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/settings/settings_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/clickable.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(
      settingsViewModel.select((state) => state.locale.languageCode),
    );

    final languageIcons = [Assets.graphics.english];

    final localizations = context.l10n;

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitleBar(title: localizations.language),
              const Space.vertical(24.0),
              for (final (index, locale)
                  in AppLocalizations.supportedLocales.indexed)
                Clickable(
                  highlightColor: ColorName.oceanGreenSwatch[50]!,
                  onClick: () {
                    ref.read(settingsViewModel.notifier).update(locale: locale);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.dx(16.0)),
                    child: Row(
                      children: [
                        languageIcons[index].svg(
                          height: context.dx(24.0),
                          width: context.dx(24.0),
                          fit: BoxFit.cover,
                        ),
                        const Space.horizontal(8.0),
                        Text(
                          '${languageNames[locale.languageCode]}',
                          style: context.textStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        if (locale.languageCode == languageCode)
                          Assets.graphics.checkedCircle.svg(
                            height: context.dx(16.0),
                            width: context.dx(16.0),
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
