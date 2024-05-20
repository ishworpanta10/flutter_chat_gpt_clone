import 'package:flutter/material.dart';
import 'package:gpt_clone/feature/gpt_clone/models/gpt_history_model.dart';

import '../../../../core/core_barrel.dart';

class DrawerGPTHistory extends StatelessWidget {
  final String titleDate;
  final GPTHistoryModel gptHistory;
  const DrawerGPTHistory({
    super.key,
    required this.titleDate,
    required this.gptHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.grey,
                ),
          ),
          gapH16,

          // GPT latest history list
          for (final gpt in gptHistory.gptHistory)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p12),
              child: Text(
                gpt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: Sizes.p16,
                ),
              ),
            ),

          const Divider(),
        ],
      ),
    );
  }
}
