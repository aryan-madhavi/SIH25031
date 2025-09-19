import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/providers/urgency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UrgencyButtonWidget extends ConsumerWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const UrgencyButtonWidget({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUrgency = ref.watch(urgencyProvider);

    final bool isSelected = selectedUrgency == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(urgencyProvider.notifier).update((state) => label);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2.5,
              color: isSelected ? color : ColorConstants.darkGreyColor,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: ResponsiveService.w(0.06)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: ResponsiveService.fs(0.04),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
