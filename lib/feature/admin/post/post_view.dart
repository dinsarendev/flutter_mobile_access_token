import 'package:cached_network_image/cached_network_image.dart';
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
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppbarCustomWidget(
          title: "List Post",
        ),
        body: controller.postList.isEmpty
            ? const Center(
          child: Text(
            "No posts available",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          itemCount: controller.postList.length,
          itemBuilder: (context, index) {
            final post = controller.postList[index];

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  CachedNetworkImage(
                    imageUrl: "${post.image}",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 220,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 220,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  /// Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        Text(
                          "${post.title}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Tags
                        if (post.tags != null &&
                            post.tags!.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: post.tags!.map<Widget>((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.cyan.withOpacity(0.1),
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "$tag",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                        const SizedBox(height: 16),

                        Divider(
                          color: Colors.grey.shade200,
                          height: 1,
                        ),

                        const SizedBox(height: 12),

                        /// Reactions
                        Row(
                          children: [
                            _buildReactionItem(
                              icon: Icons.thumb_up_alt_outlined,
                              label: "Likes",
                              count: post.reactions?.likes ?? 0,
                              color: Colors.blue,
                            ),

                            const SizedBox(width: 24),

                            _buildReactionItem(
                              icon: Icons.thumb_down_alt_outlined,
                              label: "Dislikes",
                              count:
                              post.reactions?.dislikes ?? 0,
                              color: Colors.red,
                            ),

                            const Spacer(),

                            IconButton(
                              onPressed: () {
                                // Navigate to detail
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
  Widget _buildReactionItem({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          "$count",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
