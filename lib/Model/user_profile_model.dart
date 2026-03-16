class UserProfile {
  final String name;
  final String location;
  final String mobileNumber;
  final String email;
  final String linkedinUrl;
  final String profileImage;
  final String coverImage;

  const UserProfile({
    required this.name,
    required this.location,
    required this.mobileNumber,
    required this.email,
    required this.linkedinUrl,
    required this.profileImage,
    required this.coverImage,
  });

  UserProfile copyWith({
    String? name,
    String? location,
    String? mobileNumber,
    String? email,
    String? linkedinUrl,
    String? profileImage,
    String? coverImage,
  }) {
    return UserProfile(
      name: name ?? this.name,
      location: location ?? this.location,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}