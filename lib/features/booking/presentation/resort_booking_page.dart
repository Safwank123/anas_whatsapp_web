import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../shared/responsive.dart';
import '../../../shared/widgets/fade_in.dart';
import 'widgets/booking_form_card.dart';
import 'widgets/footer_section.dart';
import 'widgets/gallery_section.dart';
import 'widgets/highlights_section.dart';
import 'widgets/testimonials_section.dart';

class ResortBookingPage extends StatelessWidget {
  const ResortBookingPage({super.key});

  static const _heroImage =
      'https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&w=2400&q=85';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _HeroSection(imageUrl: _heroImage)),
          const SliverToBoxAdapter(child: HighlightsSection()),
          const SliverToBoxAdapter(child: GallerySection()),
          const SliverToBoxAdapter(child: TestimonialsSection()),
          const SliverToBoxAdapter(child: FooterSection()),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final safeViewportHeight = viewportHeight.isFinite && viewportHeight > 0
        ? viewportHeight
        : 760.0;
    final heroHeight = isMobile
        ? math.max(safeViewportHeight, 980.0)
        : math.max(safeViewportHeight, 760.0);
    final padding = Responsive.pagePadding(context);

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppColors.forest),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.54),
                  AppColors.deepForest.withValues(alpha: 0.68),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
              child: Column(
                children: [
                  const _TopBar(),
                  const Spacer(),
                  FadeIn(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1180),
                      child: isMobile
                          ? const _MobileHeroContent()
                          : const _DesktopHeroContent(),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.isMobile(context);

    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.jpeg'),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'STAY HERE',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            letterSpacing: 0,
          ),
        ),
        const Spacer(),
        if (!compact)
          const Row(
            children: [
              _NavText('Highlights'),
              _NavText('Gallery'),
              _NavText('Stories'),
              _NavText('Contact'),
            ],
          ),
      ],
    );
  }
}

class _NavText extends StatelessWidget {
  const _NavText(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white.withValues(alpha: 0.82),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DesktopHeroContent extends StatelessWidget {
  const _DesktopHeroContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'STAY HERE',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 72, height: 1.02),
              ),
              const SizedBox(height: 22),
              Text(
                'Private villas, quiet gardens, and golden-hour dining beside the coast.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.88),
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 56),
        const SizedBox(width: 460, child: BookingFormCard()),
      ],
    );
  }
}

class _MobileHeroContent extends StatelessWidget {
  const _MobileHeroContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'STAY HERE',
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontSize: 48, height: 1.05),
        ),
        const SizedBox(height: 14),
        Text(
          'Luxury stays wrapped in forest calm and coastal light.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.88),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        const BookingFormCard(),
      ],
    );
  }
}
