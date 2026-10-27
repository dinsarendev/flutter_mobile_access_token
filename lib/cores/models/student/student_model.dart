import 'package:flutter_mobile_access_token/constants/constant_uri.dart';

class StudentModel {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? phoneNumber;
  String? image;
  String? status;
  String? createAt;
  String? createBy;

  StudentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.image,
    this.status,
    this.createAt,
    this.createBy,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      fullName: json['fullName']?.toString() ??
          '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      phoneNumber: json['phoneNumber']?.toString(),
      image: json['image']?.toString(),
      status: json['status']?.toString() ?? 'ACT',
      createAt: json['createAt']?.toString(),
      createBy: json['createBy']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'image': image,
      'status': status,
    };
  }

  String get fullImageUrl {
    if (image == null || image!.isEmpty) return '';
    if (image!.startsWith('http://') || image!.startsWith('https://')) {
      return image!;
    }
    return '${ConstantUri.viewImagePath}$image';
  }

  String get initials {
    if (fullName != null && fullName!.trim().isNotEmpty) {
      final parts = fullName!.trim().split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    if (firstName != null && firstName!.isNotEmpty) {
      return firstName![0].toUpperCase();
    }
    return 'S';
  }
}

class StudentPageResponse {
  String? code;
  String? message;
  List<StudentModel>? content;
  int? page;
  int? size;
  int? totalElements;
  int? totalPages;
  bool? last;

  StudentPageResponse({
    this.code,
    this.message,
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  });

  factory StudentPageResponse.fromJson(dynamic json) {
    List<StudentModel> items = [];
    int? page;
    int? size;
    int? totalElements;
    int? totalPages;
    bool? last;

    if (json is Map<String, dynamic>) {
      final data = json['data'];
      if (data is Map<String, dynamic>) {
        if (data['content'] is List) {
          items = (data['content'] as List)
              .map((v) => StudentModel.fromJson(v as Map<String, dynamic>))
              .toList();
        }
        page = data['page'];
        size = data['size'];
        totalElements = data['totalElements'];
        totalPages = data['totalPages'];
        last = data['last'];
      } else if (data is List) {
        items = data
            .map((v) => StudentModel.fromJson(v as Map<String, dynamic>))
            .toList();
      }
      return StudentPageResponse(
        code: json['code']?.toString(),
        message: json['message']?.toString(),
        content: items,
        page: page,
        size: size,
        totalElements: totalElements,
        totalPages: totalPages,
        last: last,
      );
    }

    return StudentPageResponse(content: items);
  }
}

