import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Reusable loading widget
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.message,
    this.size = 40,
  });

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              color: ColorManager.primary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
