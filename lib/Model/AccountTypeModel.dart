class AccountTypeModelFull {
  String userId;
  String name;
  String email;
  String mobile;
  String address;
  String dob;
  String profileImage;
  String? accountType;

  AccountTypeModelFull({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.dob,
    required this.profileImage,
    this.accountType,
  });
}
