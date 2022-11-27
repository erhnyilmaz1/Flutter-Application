// ignore_for_file: prefer_collection_literals, unnecessary_this

class Category {
  int? categoryId;
  String? categoryName;

  Category(this.categoryName);
  Category.withID(this.categoryId, this.categoryName);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["categoryId"] = categoryId;
    map["categoryName"] = categoryName;
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this.categoryId = map["categoryId"];
    this.categoryName = map["categoryName"];
  }

  @override
  String toString() {
    return "Category{categoryId: $categoryId , categoryName: $categoryName }";
  }
}
