import 'package:flutter_mobile_access_token/routes/app_route_name.dart';

class Menu {
  int? id;
  String? name;
  String? nameKm;
  String? routeName;

  Menu({this.id, this.routeName, this.nameKm, this.name});

  static List<Menu> getAllMenus() {
    return [
      Menu(id: 1, name: "Home", nameKm: "Home", routeName: AppRouteName.home),
      Menu(
        id: 2,
        name: "Category",
        nameKm: "Category",
        routeName: AppRouteName.home,
      ),
      Menu(
        id: 3,
        name: "Article",
        nameKm: "Category",
        routeName: AppRouteName.home,
      ),
      Menu(id: 4, name: "Post", nameKm: "Post", routeName: AppRouteName.adminPosts),
    ];
  }
}
