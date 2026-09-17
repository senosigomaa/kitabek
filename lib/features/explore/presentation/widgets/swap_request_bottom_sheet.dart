import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/book_model.dart';

class SwapRequestBottomSheet extends StatefulWidget {
  final BookModel targetBook;

  const SwapRequestBottomSheet({super.key, required this.targetBook});

  @override
  State<SwapRequestBottomSheet> createState() => _SwapRequestBottomSheetState();
}

class _SwapRequestBottomSheetState extends State<SwapRequestBottomSheet> {
  // قائمة كتب المستخدم التي يعرضها للمقايضة (Mocked Bookshelf)
  final List<Map<String, String>> myBooks = [
    {
      'title': 'عالم صوفي',
      'cover': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&q=80&w=200',
    },
    {
      'title': 'Refactoring',
      'cover': 'https://images.unsplash.com/photo-1532012164546-f432f2e3777a?auto=format&fit=crop&q=80&w=200',
    },
    {
      'title': 'Flutter In Action',
      'cover': 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=200',
    },
  ];

  int selectedBookIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0E1624) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مقبض الـ Sheet بالأعلى
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),

          const Text(
            'اختر كتاباً من مكتبتك لتبادله معه 🔄',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'سيصل إشعار إلى ${widget.targetBook.ownerName} لمراجعة عرضك والاتفاق.',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),

          const SizedBox(height: 20),

          // قائمة كتب المستخدم الأفقية للاختيار بضغطة
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myBooks.length,
              itemBuilder: (context, index) {
                final isSelected = selectedBookIndex == index;
                final book = myBooks[index];

                return GestureDetector(
                  onTap: () => setState(() => selectedBookIndex = index),
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.neonEmerald.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.neonEmerald
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: book['cover']!,
                            height: 110,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          book['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // زر تأكيد إرسال الطلب
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.neonEmerald,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: Text(
                      'تم إرسال عرض مقايضة (${myBooks[selectedBookIndex]['title']}) بنجاح! 🚀',
                      style: const TextStyle(
                        color: Color(0xFF03140E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonEmerald,
                foregroundColor: const Color(0xFF03140E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'تأكيد إرسال العرض',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
