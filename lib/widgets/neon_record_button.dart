import 'dart:math';
import 'package:flutter/material.dart';

class NeonRecordButton extends StatefulWidget {
  final bool isRecording;
  final int countdown;
  final VoidCallback onRecord;
  final VoidCallback onStop;
  final VoidCallback onSwitchCamera;

  const NeonRecordButton({
    super.key,
    required this.isRecording,
    required this.countdown,
    required this.onRecord,
    required this.onStop,
    required this.onSwitchCamera,
  });

  @override
  State<NeonRecordButton> createState() => _NeonRecordButtonState();
}

class _NeonRecordButtonState extends State<NeonRecordButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _smallButton({
    required IconData icon,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: colors,
            stops: const [0.0, 0.5, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.6),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ⭐ STOP
        _smallButton(
          icon: Icons.stop,
          colors: const [Colors.red, Colors.orange],
          onTap: widget.onStop,
        ),

        const SizedBox(width: 30),

        // ⭐ PULSANTE CENTRALE NEON + COUNTDOWN
        GestureDetector(
          onTap: widget.isRecording ? widget.onStop : widget.onRecord,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ⭐ Cerchio neon esterno
                Container(
                  width: 110,
                  height: 110,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: const [
                        Colors.yellow,
                        Colors.orange,
                        Colors.red,
                        Colors.yellow,
                      ],
                      stops: const [0.0, 0.33, 0.66, 1.0],
                      transform: GradientRotation(_controller.value * 2 * pi),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),

                // ⭐ Countdown neon (stroke 8–10)
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CustomPaint(
                    painter: _CountdownPainter(
                      progress: widget.countdown / 15,
                    ),
                  ),
                ),

                // ⭐ Cerchio interno nero
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),

                // ⭐ Icona centrale
                Icon(
                  widget.isRecording ? Icons.stop : Icons.fiber_manual_record,
                  color: widget.isRecording ? Colors.orange : Colors.red,
                  size: 48,
                ),

                // ⭐ Numeri countdown (ROSSI)
                if (widget.isRecording)
                  Positioned(
                    bottom: 8,
                    child: Text(
                      "${widget.countdown}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 30),

        // ⭐ SWITCH CAMERA
        _smallButton(
          icon: Icons.cameraswitch,
          colors: const [Colors.yellow, Colors.orange],
          onTap: widget.onSwitchCamera,
        ),
      ],
    );
  }
}

class _CountdownPainter extends CustomPainter {
  final double progress;

  _CountdownPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Colors.yellow,
          Colors.orange,
          Colors.red,
          Colors.yellow,
        ],
        stops: const [0.0, 0.33, 0.66, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
