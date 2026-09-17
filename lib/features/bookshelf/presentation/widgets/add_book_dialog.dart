import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../explore/data/models/book_model.dart';

class AddBookDialog extends StatefulWidget {
  final Function(BookModel) onBookAdded;

  const AddBookDialog({super.key, required this.onBookAdded});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  SwapType _swapType = SwapType.permanent;
  String _condition = 'كالجديد';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0E1624) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'إضافة كتاب جديد للتبادل 📚',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'اسم الكتاب',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'اسم المؤلف',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // نوع التبادل
            Row(
              children: [
                const Text('نوع التبادل: ', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('مقايضة دائمة'),
                  selected: _swapType == SwapType.permanent,
                  selectedColor: AppColors.neonEmerald.withOpacity(0.2),
                  onSelected: (val) => setState(() => _swapType = SwapType.permanent),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('إعارة مؤقتة'),
                  selected: _swapType == SwapType.temporary,
                  selectedColor: AppColors.warmAmber.withOpacity(0.2),
                  onSelected: (val) => setState(() => _swapType = SwapType.temporary),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.trim().isEmpty) return;

                  final newBook = BookModel(
                    id: 'book_${DateTime.now().millisecondsSinceEpoch}',
                    isbn: '622300${DateTime.now().millisecond}',
                    title: _titleController.text.trim(),
                    author: _authorController.text.trim().isEmpty
                        ? 'مؤلف غير معروف'
                        : _authorController.text.trim(),
                    coverUrl:
                        'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=300',
                    ownerName: 'أنا',
                    distanceKm: 0.0,
                    swapType: _swapType,
                    condition: _condition,
                    description: 'متاح للتبادل مع قراء المنطقة.',
                  );

                  widget.onBookAdded(newBook);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonEmerald,
                  foregroundColor: const Color(0xFF03140E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('حفظ الكتاب في مكتبتي 🚀', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
