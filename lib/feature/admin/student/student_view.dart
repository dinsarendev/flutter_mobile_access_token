import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/cores/models/student/student_model.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/student_controller.dart';
import 'package:flutter_mobile_access_token/widgets/appbar_custom_widget.dart';
import 'package:flutter_mobile_access_token/widgets/button_custom_widget.dart';
import 'package:flutter_mobile_access_token/widgets/input_custom_widget.dart';
import 'package:get/get.dart';

class StudentView extends GetView<StudentController> {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppbarCustomWidget(
        title: "Students",
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => controller.onGetStudents(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: TextField(
              controller: controller.searchController,
              onChanged: (val) => controller.onSearch(val),
              decoration: InputDecoration(
                hintText: "Search student by name or phone...",
                hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 22),
                suffixIcon: Obx(() {
                  return controller.hasSearchText.value
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: controller.onClearSearch,
                        )
                      : const SizedBox.shrink();
                }),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Student List or Empty State
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
                );
              }

              if (controller.studentList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => controller.onGetStudents(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.school_outlined,
                                size: 40,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Students Found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Tap the '+' button below to add your first student",
                              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                color: const Color(0xFF4F46E5),
                onRefresh: () => controller.onGetStudents(),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.studentList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final student = controller.studentList[index];
                    return _buildStudentCard(context, student);
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 4,
        onPressed: () => _showAddStudentBottomSheet(context),
        icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
        label: const Text(
          "Add Student",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, StudentModel student) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E7FF), width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: student.image != null && student.image!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: student.fullImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Center(
                      child: Text(
                        student.initials,
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Center(
                      child: Text(
                        student.initials,
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      student.initials,
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
          ),

          const SizedBox(width: 14),

          // Student Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        student.fullName ?? "No Name",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        student.status == 'ACT' ? 'Active' : (student.status ?? 'Active'),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      student.phoneNumber ?? "",
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Menu / Delete Button
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 22),
            onPressed: () {
              if (student.id != null) {
                controller.onDeleteStudent(student.id!);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddStudentBottomSheet(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "Create New Student",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Fill in student contact and profile information",
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 20),
              InputCustomWidget(
                labelText: "First Name",
                hintText: "e.g. Saren",
                controller: firstNameController,
              ),
              const SizedBox(height: 14),
              InputCustomWidget(
                labelText: "Last Name",
                hintText: "e.g. Din",
                controller: lastNameController,
              ),
              const SizedBox(height: 14),
              InputCustomWidget(
                labelText: "Phone Number",
                hintText: "e.g. 012345678",
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 24),
              Obx(() => ButtonCustomWidget(
                    loading: controller.isSubmitting.value,
                    title: "Save Student",
                    icon: Icons.check_circle_outline_rounded,
                    onClick: () async {
                      final success = await controller.onCreateStudent(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneController.text,
                      );
                      if (success) {
                        Get.back();
                      }
                    },
                  )),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

