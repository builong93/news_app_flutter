import 'objectbox.g.dart';
import './data/model/article.dart';

class ObjectBox {
  late final Store store;
  late final Box<Article> articleBox;

  ObjectBox._create(this.store) {
    articleBox = Box<Article>(store);
  }
  static Future<ObjectBox> create() async {
    final store = await openStore(); // Mở kho dữ liệu ObjectBox
    return ObjectBox._create(store);
  }
}
