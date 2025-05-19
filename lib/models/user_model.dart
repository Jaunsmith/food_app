class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.phone,
    required this.email,
    required this.name,
    required this.id,
    required this.orderCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json['phone']?.toString() ?? '', // Handle null & convert to String
      email: json['email']?.toString() ?? '',
      name: json['f_name']?.toString() ?? '', // Map 'f_name' to 'name'
      id: json['id'] as int? ?? 0,
      orderCount: json['order_count'] as int? ?? 0,
    );
  }
}
