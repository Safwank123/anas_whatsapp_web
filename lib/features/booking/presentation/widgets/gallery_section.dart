import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/fade_in.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  static const images = [
    'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=82',
    'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1200&q=82',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=82',
    'https://images.unsplash.com/photo-1602002418082-a4443e081dd1?auto=format&fit=crop&w=1200&q=82',
  ];

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final mobile = Responsive.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 84),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gallery',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Spaces shaped for sunlit mornings and slow evenings.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.charcoal.withValues(alpha: 0.68),
                    ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: mobile ? 1 : 4,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: mobile ? 1.55 : 0.82,
                ),
                itemBuilder: (context, index) {
                  return FadeIn(
                    delay: Duration(milliseconds: index * 90),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(images[index], fit: BoxFit.cover),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.deepForest.withValues(alpha: 0.32),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
