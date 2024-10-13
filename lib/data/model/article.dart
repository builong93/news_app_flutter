import 'package:objectbox/objectbox.dart';

@Entity()
class Article {
  int id; // ObjectBox cần có trường 'id' làm khóa chính
  String title;
  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;
  String imageUrl;
  String cre;
  Article({
    this.id = 0, // ID sẽ được tự động tạo
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.cre,
  });
}
