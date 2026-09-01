import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/home/home_controller.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:get/get.dart';

import '../../widgets/appbar_custom_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.cyan,
        child: ListView(
          children: [
            SizedBox(height: 150),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Get.toNamed(AppRouteName.adminDashboard);
              },
              leading: Icon(Icons.dashboard, color: Colors.white),
              title: Text("dashboard", style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.navigate_next, color: Colors.white),
            ),
          ],
        ),
      ),
      appBar: AppbarCustomWidget(
        title: "Home Screen",
        actions: [
          IconButton(
            onPressed: () {
              controller.onLogout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
