import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  final String? title;
  final bool loading;
  final VoidCallback? onClick;
  final Color? color;
  final Gradient? gradient;
  final IconData? icon;

  const ButtonCustomWidget({
    super.key,
    this.title,
    this.onClick,
    this.loading = false,
    this.color,
    this.gradient,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ??
        (color == null
            ? const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null);

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: effectiveGradient == null ? (color ?? const Color(0xFF4F46E5)) : null,
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: loading ? null : onClick,
          child: Center(
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        title ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
