import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabek/features/explore/presentation/screens/book_details_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/book_vertical_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header المستخدم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.neonEmerald, Color(0xFF065F46)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'س',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('أهلاً، سنوسي 🔥', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text(
                          'الشيخ زايد • مجتمع القراء',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2. شريط البحث السريع
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(LucideIcons.search, size: 18, color: AppColors.neonEmerald),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'ابحث عن كتاب، مؤلف، أو ISBN...',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Icon(LucideIcons.slidersHorizontal, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              // 3. سيكشن كتب قريبة منك
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('كتب قريبة منك 📍', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    Text(
                      'الرادار الجغرافي',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonEmerald,
                      ),
                    ),
                  ],
                ),
              ),

              // 4. البلوك وحالة جلب الكتب
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoadingState) {
                    return SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
                            child: Container(
                              width: 165,
                              margin: const EdgeInsets.only(left: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  if (state is ExploreLoadedState) {
                    return SizedBox(
                      height: 310,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          final book = state.books[index];
                          return BookVerticalCard(
                            book: book,
                           onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookDetailsScreen(book: book),
    ),
  );
},

                          );
                        },
                      ),
                    );
                  }

                  return const Center(child: Text('حدث خطأ في تحميل البيانات'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
