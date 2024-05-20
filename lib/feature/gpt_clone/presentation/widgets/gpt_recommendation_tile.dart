import 'package:flutter/material.dart';

import '../../../../core/core_barrel.dart';

class GptRecommendationTile extends StatelessWidget {
  const GptRecommendationTile({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p250,
      margin: const EdgeInsets.only(right: Sizes.p16),
      padding: const EdgeInsets.all(Sizes.p16),
      decoration: BoxDecoration(
        color: AppTheme.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Sizes.p16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            subtitle,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.grey),
          )
        ],
      ),
    );
  }
}
