import 'package:spa_ceylon/models/category_model.dart';

class Categories {
  static List<CategoryModel> list = [
    CategoryModel(id: 'skin_wellness', category: 'Skin Wellness'),
    CategoryModel(id: 'fragrances', category: 'Fragrances'),
    CategoryModel(id: 'mind_and_body', category: 'Mind & Body'),
    CategoryModel(id: 'hair_wellness', category: 'Hair Wellness'),
    CategoryModel(id: 'home_wellness', category: 'Home Wellness'),
  ];

  static CategoryModel findCategoryById(String id) {
    return list.firstWhere((categoryModel) => categoryModel.id == id);
  }
}
