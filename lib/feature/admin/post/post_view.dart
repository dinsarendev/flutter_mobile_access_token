import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/dashboard_controller.dart';
import 'package:flutter_mobile_access_token/feature/admin/post/post_controller.dart';
import 'package:flutter_mobile_access_token/widgets/appbar_custom_widget.dart';
import 'package:get/get.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppbarCustomWidget(title: "List Post"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView.builder(
            itemCount: controller.postList.length,
            itemBuilder: (context, index) {
              var menu = controller.postList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                width: double.infinity,
                child: Column(
                  children: [
                    Image.network("${menu.image}"),
                    Center(
                      child: Text(
                        "${menu.title}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
