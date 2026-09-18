import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_book_image.dart';
import '../../data/models/book_model.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_state.dart';
import '../widgets/book_vertical_card.dart';
import 'all_books_screen.dart';
import 'book_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'الكل 📚',
    'أدب وروايات 🏛️',
    'فلسفة وفكر 💡',
    'تاريخ وسياسة 📜',
    'تكنولوجيا وبرمجة 💻'
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. الهيدر والترحيب
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.neonEmerald, Color(0xFF065F46)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'س',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'أهلاً، سنوسي 🔥',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                        ),
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

              // 2. شريط البحث المنبثق
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    final allBooks = state is ExploreLoadedState ? state.books : <BookModel>[];
                    return GestureDetector(
                      onTap: () {
                        if (allBooks.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllBooksScreen(initialBooks: allBooks),
                            ),
                          );
                        }
                      },
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
                    );
                  },
                ),
              ),

              // 3. شريط تصنيفات الكتب السريعة
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategoryIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.neonEmerald
                                : (isDark ? AppColors.darkCardBg : AppColors.lightCardBg),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                            ),
                          ),
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? const Color(0xFF03140E)
                                  : (isDark ? Colors.white70 : Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 4. سيكشن "كتب قريبة منك" مع زر "عرض الكل"
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('كتب قريبة منك 📍', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    BlocBuilder<ExploreBloc, ExploreState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (state is ExploreLoadedState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AllBooksScreen(initialBooks: state.books),
                                ),
                              );
                            }
                          },
                          child: const Row(
                            children: [
                              Text(
                                'عرض الكل',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.neonEmerald,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(LucideIcons.chevronLeft, size: 16, color: AppColors.neonEmerald),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // 5. شريط الكتب الأفقية (Horizontal Carousel)
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoadingState) {
                    return SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 3,
                        itemBuilder: (_, __) => Shimmer.fromColors(
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
                        ),
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
                                  builder: (_) => BookDetailsScreen(book: book),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const Center(child: Text('تعذر تحميل الكتب'));
                },
              ),

              // 6. سيكشن إضافي: "الأكثر طلباً وتداولاً في زايد 🔥"
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('الأكثر طلباً وتداولاً 🔥', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    Text(
                      'ترند الأسبوع',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // كروت قائمة رأسية للكتب الرائجة
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoadedState) {
                    final trendingBooks = state.books.reversed.take(3).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: trendingBooks.length,
                      itemBuilder: (context, index) {
                        final book = trendingBooks[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book)),
                              );
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: AppBookImage(
                                    imagePath: book.coverUrl,
                                    height: 70,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        book.author,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(LucideIcons.flame, size: 14, color: AppColors.warmAmber),
                                          const SizedBox(width: 4),
                                          Text(
                                            'مطلوب ${index + 4} مرات هذا الشهر',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.warmAmber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(LucideIcons.chevronLeft, size: 18, color: Colors.grey),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
