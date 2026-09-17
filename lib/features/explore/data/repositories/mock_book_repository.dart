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
            'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=400',
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
            'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=400',
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
        coverUrl:
            'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=400',
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
            'https://images.unsplash.com/photo-1495640388908-05fa85288e61?auto=format&fit=crop&q=80&w=400',
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
            'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&q=80&w=400',
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
