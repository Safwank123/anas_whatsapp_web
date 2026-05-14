import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../shared/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final mobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.deepForest,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 46),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Brand(context),
                    const SizedBox(height: 18),
                    _Contact(context),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _Brand(context)),
                    _Contact(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _Brand(BuildContext context) {
    return Text(
      'Stay here',
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: Colors.white),
    );
  }

  Widget _Contact(BuildContext context) {
    return Text(
      'reservations@stayhere.com  |  +91 98765 43210',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.white.withValues(alpha: 0.74),
      ),
    );
  }
}
