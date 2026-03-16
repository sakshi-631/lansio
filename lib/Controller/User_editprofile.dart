import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditContractorProfile extends StatefulWidget {
  final Map<String, dynamic>? profileData;

  const EditContractorProfile({super.key, this.profileData});

  @override
  State<EditContractorProfile> createState() => _EditContractorProfileState();
}

class _EditContractorProfileState extends State<EditContractorProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  File? _profileImageFile;
  File? _coverImageFile;

  @override
  void initState() {
    super.initState();
    if (widget.profileData != null) {
      _nameController.text = widget.profileData!['name'] ?? '';
      _locationController.text = widget.profileData!['location'] ?? '';
      _aboutController.text = widget.profileData!['about'] ?? '';

      final existingProfileImagePath = widget.profileData!['imagePath'];
      if (existingProfileImagePath != null) {
        _profileImageFile = File(existingProfileImagePath);
      }

      final existingCoverImagePath = widget.profileData!['coverImagePath'];
      if (existingCoverImagePath != null) {
        _coverImageFile = File(existingCoverImagePath);
      }
    }
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImageFile = File(picked.path);
      });
    }
  }

  Future<void> _pickCoverImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _coverImageFile = File(picked.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> updatedProfile = {
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'about': _aboutController.text.trim(),
        'imagePath': _profileImageFile?.path,
        'coverImagePath': _coverImageFile?.path,
      };

      Navigator.pop(context, updatedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF4CAF50),
          content: Text(widget.profileData == null
              ? 'Profile Created Successfully!'
              : 'Profile Updated Successfully!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          widget.profileData == null ? 'Add Profile' : 'Edit Profile',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Cover Image Picker ---
              GestureDetector(
                onTap: _pickCoverImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    image: _coverImageFile != null
                        ? DecorationImage(
                            image: FileImage(_coverImageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _coverImageFile == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.photo_library,
                                  color: Colors.green, size: 40),
                              SizedBox(height: 8),
                              Text(
                                'Tap to set Cover Image',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 30),

              // --- Profile Picture Picker ---
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.green.shade100,
                    backgroundImage: _profileImageFile != null
                        ? FileImage(_profileImageFile!)
                        : null,
                    child: (_profileImageFile == null)
                        ? const Icon(Icons.camera_alt,
                            color: Colors.green, size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- Form Fields ---
              _buildTextField(_nameController, 'Full Name', Icons.person),
              const SizedBox(height: 15),
              _buildTextField(_locationController, 'Location', Icons.location_on),
              const SizedBox(height: 15),
              _buildTextField(_aboutController, 'About You / Company',
                  Icons.info_outline,
                  maxLines: 4),
              const SizedBox(height: 30),

              // --- Save Button ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                onPressed: _saveProfile,
                child: Text(
                  widget.profileData == null
                      ? 'Create Profile'
                      : 'Save Changes',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color(0xFF4CAF50), width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }
}
