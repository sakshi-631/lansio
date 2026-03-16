import 'package:flutter/material.dart';
// 🆕 Added Firebase dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProjectRequestPage extends StatefulWidget {
  // 🆕 REQUIRED FIELDS: Contractor ID and Collection Name
  final String contractorId;
  final String contractorCollection;

  const UserProjectRequestPage({
    super.key,
    required this.contractorId,
    required this.contractorCollection,
  });

  @override
  State<UserProjectRequestPage> createState() => _UserProjectRequestPageState();
}

class _UserProjectRequestPageState extends State<UserProjectRequestPage> {
  final _formKey = GlobalKey<FormState>();
  // 🆕 Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers
  final TextEditingController projectTypeController = TextEditingController();
  final TextEditingController expectedDurationController =
      TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final Color themeGreen = Colors.green;
  final Color backgroundColor = const Color(0xFFF5F5E9);

  // 🆕 Function to submit request to Firestore
  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ⚠ IMPORTANT: Get the current authenticated user's ID
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error: User is not logged in. Cannot send request."),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    final String userId = currentUser.uid;

    try {
      await _firestore.collection('requests').add({
        'projectType': projectTypeController.text.trim(),
        'expectedDuration': expectedDurationController.text.trim(),
        'requirements': requirementsController.text.trim(),
        'location': locationController.text.trim(),
        'requestedToId': widget.contractorId, // Contractor's ID
        'requestedToCollection':
            widget.contractorCollection, // 'contractors' or 'workers'
        'requestedById': userId, // Current User's ID
        'status': 'Pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // logic for send notification
      _firestore.collection("notifications").add({
        "notificationMsg": "New project request !",
        'requestedToId': widget.contractorId, // Contractor's ID
        'requestedToCollection':
            widget.contractorCollection, // 'contractors' or 'workers'
        'requestedById': userId, // Current User's ID
        'isRead': false,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        // Pop the current page after successful submission
        Navigator.of(context).pop();

        // ✅ Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Project Request Sent Successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: themeGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // ❌ Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to send request: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: themeGreen,
        centerTitle: true,
        elevation: 3,
        title: const Text(
          "Project Request",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Enter Project Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildTextField(
                      controller: projectTypeController,
                      label: "Project Type",
                      icon: Icons.work_outline,
                    ),

                    _buildTextField(
                      controller: expectedDurationController,
                      label: "Expected Duration",
                      icon: Icons.timer_outlined,
                    ),
                    _buildTextField(
                      controller: requirementsController,
                      label: "Requirements",
                      icon: Icons.list_alt_outlined,
                      maxLines: 3,
                    ),
                    _buildTextField(
                      controller: locationController,
                      label: "Location",
                      icon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton.icon(
                        // 🆕 CALL THE SUBMISSION FUNCTION
                        onPressed: _submitRequest,

                        icon: const Icon(Icons.send),
                        label: const Text(
                          "Send Request",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: themeGreen),
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: themeGreen, width: 1.5),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    projectTypeController.dispose();
    expectedDurationController.dispose();
    requirementsController.dispose();
    locationController.dispose();
    super.dispose();
  }
}