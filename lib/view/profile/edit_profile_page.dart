import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _editProfileFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String? _previousEmail;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_currentUser != null) {
      _previousEmail = _currentUser!.email;
      final doc = await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          _nameController.text = data['name'];
          _emailController.text = data['email'];
          _phoneController.text = data['phone'];
        });
      }
    }
  }

  Future<void> _updateUserProfile() async {
    if (_editProfileFormKey.currentState!.validate()) {
      try {
        if (_currentUser != null) {
          if (_currentPasswordController.text.isNotEmpty) {
            // Reauthenticate the user
            final credential = EmailAuthProvider.credential(
              email: _currentUser!.email!,
              password: _currentPasswordController.text,
            );
            await _currentUser!.reauthenticateWithCredential(credential);
          }

          if (_emailController.text != _currentUser!.email) {
            await _sendEmailVerificationToPreviousEmail();
            await _currentUser!.updateEmail(_emailController.text);
          }

          if (_newPasswordController.text.isNotEmpty) {
            await _currentUser!.updatePassword(_newPasswordController.text);
          }

          // Update Firestore
          await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).update({
            'name': _nameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully.')),
          );

          Navigator.pop(context);
        }
      } catch (e) {
        debugPrint('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile. Please try again.')),
        );
      }
    }
  }

  Future<void> _sendEmailVerificationToPreviousEmail() async {
    if (_previousEmail != null) {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://your-app-url.com/confirm?email=${_emailController.text}',
        handleCodeInApp: true,
        iOSBundleId: 'com.yourapp.bundle',
        androidPackageName: 'com.yourapp.package',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );
      await _auth.sendSignInLinkToEmail(
        email: _previousEmail!,
        actionCodeSettings: actionCodeSettings,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A verification email has been sent to your previous email address.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFF72585),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _editProfileFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _currentPasswordController,
                  decoration: const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  validator: (value) {
                    // Only validate current password if new password is entered
                    if (_newPasswordController.text.isNotEmpty && (value == null || value.isEmpty)) {
                      return 'Current password is required to change your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) {
                    // Optional field
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: const Color(0xFFF72585),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}