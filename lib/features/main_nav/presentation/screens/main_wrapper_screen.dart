import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';

// 1. Explore Feature
import '../../../explore/data/repositories/mock_book_repository.dart';
import '../../../explore/presentation/bloc/explore_bloc.dart';
import '../../../explore/presentation/bloc/explore_event.dart';
import '../../../explore/presentation/screens/explore_screen.dart';

// 2. Swaps Feature
import '../../../swaps/data/repositories/mock_swaps_repository.dart';
import '../../../swaps/presentation/bloc/swaps_bloc.dart';
import '../../../swaps/presentation/screens/swaps_screen.dart';

// 3. Chat Feature
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../../../chat/presentation/screens/chat_list_screen.dart';

// 4. Bookshelf Feature
import '../../../bookshelf/presentation/bloc/bookshelf_bloc.dart';
import '../../../bookshelf/presentation/screens/bookshelf_screen.dart';

// 5. Scanner Feature
import '../../../scanner/presentation/screens/scanner_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // تم توفير الـ BookshelfBloc هنا بالأعلى ليكون متاحاً لكل الشاشات والماسح
    return BlocProvider(
      create: (context) => BookshelfBloc()..add(LoadMyBooksEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('كتابك | Kitabek'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    isDark ? LucideIcons.sun : LucideIcons.moon,
                    color: isDark ? AppColors.warmAmber : AppColors.neonEmerald,
                  ),
                  tooltip: 'تبديل الثيم',
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                ),
              ],
            ),
            body: Stack(
              children: [
                IndexedStack(
                  index: _currentIndex,
                  children: [
                    // الشاشة 0: الرادار الجغرافي
                    BlocProvider(
                      create: (context) => ExploreBloc(
                        repository: MockBookRepository(),
                      )..add(FetchNearbyBooksEvent()),
                      child: const ExploreScreen(),
                    ),

                    // الشاشة 1: طلبات المقايضة
                    BlocProvider(
                      create: (context) => SwapsBloc(
                        repository: MockSwapsRepository(),
                      )..add(FetchSwapsEvent()),
                      child: const SwapsScreen(),
                    ),

                    // الشاشة 2: الرسائل والمحادثات
                    BlocProvider(
                      create: (context) => ChatBloc()..add(LoadConversationsEvent()),
                      child: const ChatListScreen(),
                    ),

                    // الشاشة 3: مكتبتي (أصبحت مباشرة بدون BlocProvider منفصل)
                    const BookshelfScreen(),
                  ],
                ),

                // شريط التنقل السفلي العائم
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xE60E1624)
                          : const Color(0xF2FFFFFF),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkCardBorder
                            : AppColors.lightCardBorder,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.5)
                              : Colors.black.withOpacity(0.08),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(0, LucideIcons.compass, 'الرادار', isDark),
                        _buildNavItem(1, LucideIcons.arrowLeftRight, 'المقايضات', isDark),
                        _buildScanFab(context),
                        _buildNavItem(2, LucideIcons.messageSquare, 'الرسائل', isDark),
                        _buildNavItem(3, LucideIcons.bookMarked, 'مكتبتي', isDark),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isDark) {
    final isSelected = _currentIndex == index;
    final activeColor = AppColors.neonEmerald;
    final inactiveColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: isSelected ? activeColor : inactiveColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanFab(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ScannerScreen(
                onBookScanned: (newBook) {
                  // هنا يتم الوصول للـ BookshelfBloc وإضافة الكتاب فورياً
                  context.read<BookshelfBloc>().add(AddBookToShelfEvent(newBook));
                },
              ),
            ),
          );
        },
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.warmAmber,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: AppColors.warmAmberGlow,
                blurRadius: 18,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(LucideIcons.scan, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
