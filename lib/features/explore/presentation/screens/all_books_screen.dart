import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/book_model.dart';
import '../widgets/book_vertical_card.dart';
import 'book_details_screen.dart';

class AllBooksScreen extends StatefulWidget {
  final List<BookModel> initialBooks;

  const AllBooksScreen({super.key, required this.initialBooks});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  late List<BookModel> _filteredBooks;
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedFilter = 'الكل'; // الكل، دائمة، مؤقتة، الأقرب

  @override
  void initState() {
    super.initState();
    _filteredBooks = widget.initialBooks;
  }

  void _applyFilter() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredBooks = widget.initialBooks.where((book) {
        final matchesQuery = book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);

        if (!matchesQuery) return false;

        if (_selectedFilter == 'دائمة') {
          return book.swapType == SwapType.permanent;
        } else if (_selectedFilter == 'مؤقتة') {
          return book.swapType == SwapType.temporary;
        } else if (_selectedFilter == 'الأقرب') {
          return book.distanceKm <= 1.0;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('كل الكتب المتاحة 📚', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // شريط البحث المباشر
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => _applyFilter(),
                decoration: InputDecoration(
                  icon: const Icon(LucideIcons.search, size: 18, color: AppColors.neonEmerald),
                  hintText: 'ابحث باسم الكتاب أو الكاتب...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // رقائق الفلاتر (Filter Chips)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: ['الكل', 'دائمة', 'مؤقتة', 'الأقرب'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.neonEmerald,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFF03140E)
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                    backgroundColor: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilter = filter);
                        _applyFilter();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // شبكة الكتب (Grid)
          Expanded(
            child: _filteredBooks.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد نتائج مطابقة لبحثك',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = _filteredBooks[index];
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
          ),
        ],
      ),
    );
  }
}
