import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';
import 'settings_tile.dart';

class SettingsTileGroup extends StatelessWidget {
  const SettingsTileGroup({
    required this.tileIconAssets,
    required this.onTapTile,
    required this.tileNames,
    required this.name,
    super.key,
  });

  final List<SvgGenImage> tileIconAssets;
  final ValueChanged<int> onTapTile;
  final List<String> tileNames;
  final String name;

  @override
  Widget build(BuildContext context) {
    return RaisedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Space.vertical(16.0),
          ListView.separated(
            physics: unscrollableScrollPhysics,
            separatorBuilder: (_, __) => const Space.vertical(16.0),
            itemBuilder: (_, index) => SettingsTile(
              iconAsset: tileIconAssets[index],
              onTap: () => onTapTile(index),
              name: tileNames[index],
            ),
            itemCount: tileNames.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
