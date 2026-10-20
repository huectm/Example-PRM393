import 'package:flutter/material.dart';

class AddToCartAnimation {
  static void run({
    required BuildContext context,
    required GlobalKey widgetKey,
    required GlobalKey cartKey,
    required String imageUrl,
    required VoidCallback onComplete,
  }) {
    final RenderBox? startBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? endBox =
        cartKey.currentContext?.findRenderObject() as RenderBox?;

    if (startBox == null || endBox == null) {
      onComplete();
      return;
    }

    final Offset startOffset = startBox.localToGlobal(Offset.zero);
    final Size startSize = startBox.size;
    final Offset endOffset = endBox.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _FlyingImageWidget(
        imageUrl: imageUrl,
        startOffset: startOffset,
        startSize: startSize,
        endOffset: endOffset,
        onAnimationEnd: () {
          overlayEntry.remove();
          onComplete();
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

class _FlyingImageWidget extends StatefulWidget {
  final String imageUrl;
  final Offset startOffset;
  final Size startSize;
  final Offset endOffset;
  final VoidCallback onAnimationEnd;

  const _FlyingImageWidget({
    required this.imageUrl,
    required this.startOffset,
    required this.startSize,
    required this.endOffset,
    required this.onAnimationEnd,
  });

  @override
  State<_FlyingImageWidget> createState() => _FlyingImageWidgetState();
}

class _FlyingImageWidgetState extends State<_FlyingImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _controller.forward().then((_) {
      widget.onAnimationEnd();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildImage() {
    if (widget.imageUrl.startsWith('http://') ||
        widget.imageUrl.startsWith('https://')) {
      return Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset('assets/images/dog.jpeg'),
      );
    } else {
      return Image.asset(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double value = _progressAnimation.value;

        // Tính vị trí X và Y hiện tại theo đường cong
        final double currentX =
            widget.startOffset.dx + (widget.endOffset.dx - widget.startOffset.dx) * value;
        // Võng đường cong theo trục Y cho chuyển động mềm mại
        final double curveY = (1 - (2 * value - 1) * (2 * value - 1)) * 40;
        final double currentY =
            widget.startOffset.dy + (widget.endOffset.dy - widget.startOffset.dy) * value - curveY;

        // Kích thước thu nhỏ dần từ kích thước gốc về 24x24
        final double currentWidth =
            widget.startSize.width + (24.0 - widget.startSize.width) * value;
        final double currentHeight =
            widget.startSize.height + (24.0 - widget.startSize.height) * value;

        // Độ trong suốt mờ dần về cuối
        final double opacity = (1.0 - value * 0.2).clamp(0.0, 1.0);

        return Positioned(
          left: currentX,
          top: currentY,
          child: Opacity(
            opacity: opacity,
            child: SizedBox(
              width: currentWidth,
              height: currentHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12 * (1 - value)),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: _buildImage(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
