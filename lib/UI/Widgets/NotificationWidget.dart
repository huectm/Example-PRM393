import 'package:flutter/material.dart';

enum NotificationType { success, info, warning, error }

class NotificationWidget extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final String? time;
  final VoidCallback? onClose;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.time,
    this.onClose,
  });

  // Màu sắc theo loại thông báo
  Color get _color {
    switch (type) {
      case NotificationType.success:
        return const Color(0xFF2E7D32); // Xanh lá
      case NotificationType.warning:
        return const Color(0xFFED6C02); // Cam
      case NotificationType.error:
        return const Color(0xFFD32F2F); // Đỏ
      case NotificationType.info:
      default:
        return const Color(0xFF0288D1); // Xanh dương
    }
  }

  // Biểu tượng theo loại thông báo
  IconData get _icon {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.info:
      default:
        return Icons.info_outline;
    }
  }

  // Hàm static hỗ trợ hiển thị Notification SnackBar tiện lợi
  static void showNotification(
    BuildContext context, {
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: duration,
        content: NotificationWidget(
          title: title,
          message: message,
          type: type,
          onClose: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: _color,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _icon,
              color: _color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Nội dung
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _color,
                      ),
                    ),
                    if (time != null)
                      Text(
                        time!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Nút đóng
          if (onClose != null)
            GestureDetector(
              onTap: onClose,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
