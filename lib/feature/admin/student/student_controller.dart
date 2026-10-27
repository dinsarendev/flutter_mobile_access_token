import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/cores/models/student/student_model.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/repository/student_repository.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  final StudentRepository studentRepository;

  StudentController({required this.studentRepository});

  final studentList = <StudentModel>[].obs;
  final loading = false.obs;
  final isSubmitting = false.obs;
  final hasSearchText = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    onGetStudents();
  }

  Future<void> onGetStudents({String? keyword}) async {
    loading.value = true;
    try {
      final result = await studentRepository.getStudents(
        keyword: keyword ?? searchController.text.trim(),
      );
      studentList.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to load students", snackPosition: SnackPosition.BOTTOM);
    } finally {
      loading.value = false;
    }
  }

  Future<void> onSearch(String keyword) async {
    hasSearchText.value = keyword.trim().isNotEmpty;
    await onGetStudents(keyword: keyword);
  }

  void onClearSearch() {
    searchController.clear();
    hasSearchText.value = false;
    onGetStudents();
  }

  Future<bool> onCreateStudent({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? image,
  }) async {
    if (firstName.trim().isEmpty || lastName.trim().isEmpty || phoneNumber.trim().isEmpty) {
      Get.snackbar("Validation", "First name, last name, and phone are required",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    isSubmitting.value = true;
    try {
      final success = await studentRepository.createStudent(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        image: image,
      );
      if (success) {
        Get.snackbar("Success", "Student created successfully",
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        await onGetStudents();
        return true;
      } else {
        Get.snackbar("Error", "Failed to create student. Please verify phone number is unique.",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Server error while creating student",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> onDeleteStudent(int id) async {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Delete Student", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              Get.back();
              loading.value = true;
              final success = await studentRepository.deleteStudent(id);
              loading.value = false;
              if (success) {
                studentList.removeWhere((item) => item.id == id);
                Get.snackbar("Success", "Student deleted successfully",
                    backgroundColor: const Color(0xFF10B981),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              } else {
                Get.snackbar("Error", "Failed to delete student",
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

