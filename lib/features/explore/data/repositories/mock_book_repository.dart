import '../models/book_model.dart';

class MockBookRepository {
  Future<List<BookModel>> getNearbyBooks() async {
    // محاكاة تأخير الشبكة لإظهار الـ Shimmer
    await Future.delayed(const Duration(milliseconds: 700));

    return const [
      BookModel(
        id: '1',
        isbn: '9780132350884',
        title: 'Clean Code',
        author: 'Robert C. Martin',
        coverUrl: 'https://images.unsplash.com/photo-1532012164546-f432f2e3777a?auto=format&fit=crop&q=80&w=300',
        ownerName: 'أحمد يوسف',
        distanceKm: 0.8,
        swapType: SwapType.permanent,
        condition: 'شبه جديد',
        description: 'نسخة أصلية بحالة ممتازة دون أي علامات. متاح للمقايضة بكتب معمارية برمجيات.',
      ),
      BookModel(
        id: '2',
        isbn: '9781847941831',
        title: 'Atomic Habits',
        author: 'James Clear',
        coverUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=300',
        ownerName: 'عمر كمال',
        distanceKm: 1.2,
        swapType: SwapType.temporary,
        condition: 'ممتاز',
        description: 'كتاب العادات الذرية غني عن التعريف، متاح للإعارة لمدة أسبوعين أو شهر.',
      ),
      BookModel(
        id: '3',
        isbn: '9789770914830',
        title: 'ثلاثية غرناطة',
        author: 'رضوى عاشور',
        coverUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=300',
        ownerName: 'سارة حسن',
        distanceKm: 2.0,
        swapType: SwapType.temporary,
        condition: 'جيد جداً',
        description: 'رواية تاريخية أدبية رائعة بحالة جيدة جداً، مقايضة بروايات أدبية أخرى.',
      ),
      BookModel(
        id: '4',
        isbn: '9780201616224',
        title: 'The Pragmatic Programmer',
        author: 'Andrew Hunt & David Thomas',
        coverUrl: 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=300',
        ownerName: 'إسلام محمد',
        distanceKm: 0.5,
        swapType: SwapType.permanent,
        condition: 'كالجديد',
        description: 'مرجع أساسي لكل مطور. النسخة الإنجليزية بحالة المصنع.',
      ),
    ];
  }
}
