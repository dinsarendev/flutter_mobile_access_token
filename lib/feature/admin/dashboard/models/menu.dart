import 'package:flutter_mobile_access_token/routes/app_route_name.dart';

class Menu {
  int? id;
  String? name;
  String? nameKm;
  String? routeName;

  Menu({this.id, this.routeName, this.nameKm, this.name});

  static List<Menu> getAllMenus() {
    return [
      Menu(id: 1, name: "Home", nameKm: "ទំព័រដើម", routeName: AppRouteName.home),
      Menu(
        id: 2,
        name: "Category",
        nameKm: "ប្រភេទ",
        routeName: AppRouteName.home,
      ),
      Menu(
        id: 3,
        name: "Article",
        nameKm: "អត្ថបទ",
        routeName: AppRouteName.home,
      ),
      Menu(id: 4, name: "Post", nameKm: "ប្រកាស", routeName: AppRouteName.adminPosts),
      Menu(id: 5, name: "Students", nameKm: "សិស្ស", routeName: AppRouteName.adminStudents),
    ];
  }
}
