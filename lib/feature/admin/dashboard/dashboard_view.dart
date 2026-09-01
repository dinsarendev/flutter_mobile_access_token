import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/dashboard_controller.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:flutter_mobile_access_token/widgets/appbar_custom_widget.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppbarCustomWidget(title: "Dashboard"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GridView.builder(
            itemCount: controller.menuList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              var menu = controller.menuList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(menu.routeName ?? AppRouteName.home);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),

                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "${menu.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
