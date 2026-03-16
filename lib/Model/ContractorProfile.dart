class ContractorProfile {
  final String name;
  final String location;
  final String bio;
  final String mobileNumber;
  final String email;
  final String experience;
  final String skills;
  final String linkedinUrl;
  final String instagramUrl;

  const ContractorProfile({
    required this.name,
    required this.location,
    required this.bio,
    required this.mobileNumber,
    required this.email,
    required this.experience,
    required this.skills,
    required this.linkedinUrl,
    required this.instagramUrl,
  });

  ContractorProfile copyWith({
    String? name,
    String? location,
    String? bio,
    String? mobileNumber,
    String? email,
    String? experience,
    String? skills,
    String? linkedinUrl,
    String? instagramUrl,
  }) {
    return ContractorProfile(
      name: name ?? this.name,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
    );
  }
}
