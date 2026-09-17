import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/swap_request_model.dart';

class SwapCard extends StatelessWidget {
  final SwapRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const SwapCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPending = request.status == SwapStatus.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPending
              ? AppColors.neonEmerald.withOpacity(0.4)
              : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس الكارت: الاسم والاتجاه والمسافة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.neonEmerald.withOpacity(0.15),
                    child: Text(
                      request.partnerName.characters.first,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonEmerald,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    request.partnerName,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ],
              ),
              _buildStatusBadge(request.status),
            ],
          ),

          const SizedBox(height: 14),

          // مقارنة الكتابين (المعروض مقابل المطلوب)
          Row(
            children: [
              _buildBookThumbnail(request.offeredBookCover, request.offeredBookTitle, 'يعرض لك'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(LucideIcons.arrowLeftRight, size: 18, color: AppColors.neonEmerald),
              ),
              _buildBookThumbnail(request.requestedBookCover, request.requestedBookTitle, 'يطلب منك'),
            ],
          ),

          // أزرار القبول والرفض إذا كان الطلب قيد الانتظار
          if (isPending && request.direction == SwapDirection.incoming) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(LucideIcons.check, size: 16),
                    label: const Text('قبول وبدء محادثة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonEmerald,
                      foregroundColor: const Color(0xFF03140E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onReject,
                  icon: const Icon(LucideIcons.x, size: 18, color: Colors.redAccent),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBookThumbnail(String coverUrl, String title, String tag) {
    return Expanded(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: coverUrl,
              height: 55,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tag, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(SwapStatus status) {
    switch (status) {
      case SwapStatus.pending:
        return _badge('طلب جديد', AppColors.warmAmber);
      case SwapStatus.accepted:
        return _badge('مقبول - بانتظار اللقاء', AppColors.neonEmerald);
      case SwapStatus.rejected:
        return _badge('تم الرفض', Colors.redAccent);
      case SwapStatus.completed:
        return _badge('مكتمل بنجاح', Colors.blueAccent);
    }
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
