
class PasswordData {
  String oldPassword;
  String newPassword;

  PasswordData({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
