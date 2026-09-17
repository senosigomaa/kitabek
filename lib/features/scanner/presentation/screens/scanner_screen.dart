import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../explore/data/models/book_model.dart';

class ScannerScreen extends StatefulWidget {
  final Function(BookModel) onBookScanned;

  const ScannerScreen({super.key, required this.onBookScanned});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _simulateScan() {
    // محاكاة قراءة باركود لكتاب جديد
    final scannedBook = BookModel(
      id: 'scanned_${DateTime.now().millisecondsSinceEpoch}',
      isbn: '9780132350884',
      title: 'Domain-Driven Design',
      author: 'Eric Evans',
      coverUrl:
          'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=300',
      ownerName: 'أنا',
      distanceKm: 0.0,
      swapType: SwapType.permanent,
      condition: 'ممتاز',
      description: 'كتاب هندسة البرمجيات الشهير، تم مسحه تلقائياً عبر باركود الـ ISBN.',
    );

    widget.onBookScanned(scannedBook);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.neonEmerald,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text(
          'تم مسح باركود (Domain-Driven Design) وإضافته لمكتبتك بنجاح! ⚡',
          style: TextStyle(color: Color(0xFF03140E), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // زر الإغلاق بالأعلى
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: IconButton(
                icon: const Icon(LucideIcons.x, color: Colors.white, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // إطار الماسح وخط الليزر
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppColors.neonEmerald.withOpacity(0.6),
                      width: 2,
                    ),
                    color: AppColors.neonEmerald.withOpacity(0.04),
                  ),
                  child: Stack(
                    children: [
                      // أيقونة الباركود الباهتة في الخلفية
                      const Center(
                        child: Icon(
                          LucideIcons.scanBarcode,
                          size: 70,
                          color: Colors.white12,
                        ),
                      ),

                      // أنيميشن شعاع الليزر
                      AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          return Align(
                            alignment: Alignment(
                              0.0,
                              (_animController.value * 2) - 1.0,
                            ),
                            child: Container(
                              height: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColors.neonEmerald,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonEmerald,
                                    blurRadius: 16,
                                    spreadRadius: 2,
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

                const SizedBox(height: 26),

                const Text(
                  'امسح باركود الـ ISBN لظهر الكتاب',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'يتعرف التطبيق فورياً على الغلاف والبيانات دون كتابة حرف',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),

                const SizedBox(height: 34),

                // زر تجربة المسح التفاعلي
                ElevatedButton.icon(
                  onPressed: _simulateScan,
                  icon: const Icon(LucideIcons.zap, size: 18),
                  label: const Text('تجربة مسح كتاب فوري 🚀'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warmAmber,
                    foregroundColor: const Color(0xFF03140E),
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
