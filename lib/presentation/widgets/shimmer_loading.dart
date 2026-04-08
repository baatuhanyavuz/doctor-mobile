import 'package:flutter/material.dart';

/// Noir temalı shimmer animasyon widget'ı
///
/// Yükleme durumlarında skeleton loading efekti sağlar.
/// Koyu tema renkleri (surface → lighter surface → surface) arasında
/// soldan sağa gradyan animasyonu yapar.
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 4.0,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                Color(0xFF1E1E1E), // surface
                Color(0xFF2A2A2A), // lighter
                Color(0xFF333333), // highlight
                Color(0xFF2A2A2A), // lighter
                Color(0xFF1E1E1E), // surface
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Vaka kartı skeleton (HomeScreen loading state)
///
/// Gerçek _CaseCard layoutunu taklit eden shimmer animasyonu.
class CaseCardSkeleton extends StatelessWidget {
  const CaseCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sol: görsel placeholder
            SizedBox(
              width: 100,
              child: ShimmerLoading(height: 140),
            ),
            // Sağ: metin skeleton'ları
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    ShimmerLoading(height: 16, width: 180),
                    SizedBox(height: 12),
                    // Badge'lar
                    Row(
                      children: [
                        ShimmerLoading(height: 20, width: 60),
                        SizedBox(width: 8),
                        ShimmerLoading(height: 20, width: 70),
                      ],
                    ),
                    SizedBox(height: 14),
                    // Açıklama satırları
                    ShimmerLoading(height: 12),
                    SizedBox(height: 6),
                    ShimmerLoading(height: 12, width: 200),
                    SizedBox(height: 14),
                    // Buton placeholder
                    Align(
                      alignment: Alignment.centerRight,
                      child: ShimmerLoading(height: 14, width: 100),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Home ekranı loading skeleton'ı
///
/// 3 adet case card skeleton gösterir
class HomeScreenSkeleton extends StatelessWidget {
  const HomeScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => const CaseCardSkeleton(),
    );
  }
}

/// Game screen loading skeleton'ı
///
/// Tab bar + içerik alanı shimmer'ı
class GameScreenSkeleton extends StatelessWidget {
  const GameScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        // Tab bar placeholder
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShimmerLoading(height: 32, width: 60),
              ShimmerLoading(height: 32, width: 60),
              ShimmerLoading(height: 32, width: 60),
              ShimmerLoading(height: 32, width: 60),
              ShimmerLoading(height: 32, width: 60),
            ],
          ),
        ),
        SizedBox(height: 24),
        // İçerik alanı
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ShimmerLoading(height: 180),
                SizedBox(height: 16),
                ShimmerLoading(height: 60),
                SizedBox(height: 16),
                ShimmerLoading(height: 60),
                SizedBox(height: 16),
                ShimmerLoading(height: 40, width: 200),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
