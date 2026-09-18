import '../models/book_model.dart';

class MockBookRepository {
  Future<List<BookModel>> getNearbyBooks() async {
    // محاكاة تأخير الشبكة لإظهار الـ Shimmer
    await Future.delayed(const Duration(milliseconds: 600));

    return const [
      BookModel(
        id: '1',
        isbn: '9789770914830',
        title: 'ثلاثية غرناطة',
        author: 'رضوى عاشور',
        coverUrl:
            'https://img.youm7.com/ArticleImgs/2022/7/11/198346-293163873_5274188612646884_1706100135932055609_n.jpg',
        ownerName: 'سارة حسن',
        distanceKm: 0.6,
        swapType: SwapType.permanent,
        condition: 'ممتاز',
        description:
            'الملحمة الأندلسية الشهيرة لرضوى عاشور، طبعة دار الشروق بحالة ممتازة دون أي تدوينات.',
      ),
      BookModel(
        id: '2',
        isbn: '9789770260487',
        title: 'أولاد حارتنا',
        author: 'نجيب محفوظ',
        coverUrl:
            'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1763764913i/2364284.jpg',
        ownerName: 'أحمد يوسف',
        distanceKm: 0.9,
        swapType: SwapType.temporary,
        condition: 'شبه جديد',
        description:
            'رواية نوبل الشهيرة، متاحة للإعارة لمدة أسبوعين أو للمقايضة مع أحد أعمال يوسف إدريس.',
      ),
      BookModel(
        id: '3',
        isbn: '9789770921470',
        title: 'يوتوبيا',
        author: 'أحمد خالد توفيق',
        coverUrl: 'https://m.media-amazon.com/images/I/71IU-NkfXvL.jpg',
        ownerName: 'عمر كمال',
        distanceKm: 1.4,
        swapType: SwapType.permanent,
        condition: 'جيد جداً',
        description:
            'ديستوبيا مصرية بامتياز من العراب، طبعة مميزة ومطلوب مقايضتها مع رواية في ممر الفئران.',
      ),
      BookModel(
        id: '4',
        isbn: '9789771420880',
        title: 'رحلتي من الشك للبليد',
        author: 'مصطفى محمود',
        coverUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF0eKpolLfgecYKEztOetVwSqbN7S2h62cysP0Hj0-l_Bj0Dbaz_JRQ8M&s=10',
        ownerName: 'إسلام محمد',
        distanceKm: 2.1,
        swapType: SwapType.temporary,
        condition: 'كالجديد',
        description:
            'كتاب فكري وفلسفي ملهم، متاح للإعارة لمحبي كتب الدكتور مصطفى محمود.',
      ),
      BookModel(
        id: '5',
        isbn: '9789770932841',
        title: 'وكالة عطية',
        author: 'خيري شلبي',
        coverUrl:
            'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1517855865i/3526951.jpg',
        ownerName: 'محمود سامي',
        distanceKm: 2.8,
        swapType: SwapType.permanent,
        condition: 'ممتاز',
        description:
            'أيقونة الحارة المصرية وعالم المهمشين لخيري شلبي، بحالة نظيفة جداً.',
      ),
    ];
  }
}
