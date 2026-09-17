import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../explore/data/models/book_model.dart';
import '../bloc/bookshelf_bloc.dart';
import '../widgets/add_book_dialog.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبتي الخاصة 📖', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus, color: AppColors.neonEmerald),
            tooltip: 'إضافة كتاب',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (modalCtx) => AddBookDialog(
                  onBookAdded: (newBook) {
                    context.read<BookshelfBloc>().add(AddBookToShelfEvent(newBook));
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BookshelfBloc, BookshelfState>(
        builder: (context, state) {
          if (state is BookshelfLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookshelfLoadedState) {
            if (state.myBooks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.bookOpen, size: 60, color: isDark ? Colors.grey[800] : Colors.grey[400]),
                    const SizedBox(height: 12),
                    const Text('مكتبتك فارغة حالياً', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('أضف كتبك غير المستخدمة لمبادلتها مع الجيران', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: state.myBooks.length,
              itemBuilder: (context, index) {
                final book = state.myBooks[index];
                return _buildGridBookCard(context, book, isDark);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGridBookCard(BuildContext context, BookModel book, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: book.coverUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                book.swapType == SwapType.permanent ? 'مقايضة' : 'إعارة',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neonEmerald,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<BookshelfBloc>().add(RemoveBookFromShelfEvent(book.id));
                },
                child: const Icon(LucideIcons.trash2, size: 15, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
