import 'package:flutter/material.dart';
import '../models/user_details.dart';
import '../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UserDetails userDetails;

  const EditProfileScreen({super.key, required this.userDetails});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _stateController;
  late TextEditingController _districtController;

  late TextEditingController _cityController;

  late TextEditingController _cropController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user details
    _nameController = TextEditingController(text: widget.userDetails.name);
    _emailController = TextEditingController(text: widget.userDetails.email);
    _stateController = TextEditingController(text: widget.userDetails.state);
    _districtController = TextEditingController(text: widget.userDetails.district);
    _cityController = TextEditingController(text: widget.userDetails.city);
    _cropController = TextEditingController(text: widget.userDetails.crop);
  }

  // Save profile changes
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create updated user details
      UserDetails updatedUserDetails = UserDetails(
        name: _nameController.text,
        email: _emailController.text,
        state: _stateController.text,
        city: _cityController.text,
        district:_districtController.text,
        crop: _cropController.text,
      );

      try {
        // Save to SharedPreferences using UserPreferences
        final success = await UserPreferences.saveUserDetails(updatedUserDetails);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          Navigator.pop(context, updatedUserDetails); // Return updated details
        } else {
          throw Exception('Failed to save user details');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _stateController,
                label: 'State',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _cityController,
                label: 'City',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _cropController,
                label: 'Crop',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your crop';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _cropController.dispose();
    super.dispose();
  }
}
