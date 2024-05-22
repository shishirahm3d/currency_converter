import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:currency_converter/login_signup/login_page.dart';
import 'package:currency_converter/view/profile/edit_profile_page.dart';
import 'package:currency_converter/view/profile/about_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _newProfileImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  String? _profileUrl;
  String _name = '';
  String _email = '';
  bool _isGuest = false;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      _isGuest = _currentUser!.isAnonymous;
      if (_isGuest) {
        setState(() {
          _name = 'Anonymous';
          _email = 'anonymous@gmail.com';
          //_profileUrl = 'assets/images/anon.png';
        });
      } else {
        _loadUserData();
      }
    }
  }

  Future<void> _loadUserData() async {
    if (_currentUser != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          _name = data['name'];
          _email = data['email'];
          _profileUrl = data['profile-url'];
        });
      }
    }
  }

  Future<void> _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() => _newProfileImage = File(image.path));

      // If profile picture doesn't exist, upload the new image
      if (_profileUrl == null) {
        _uploadProfileImage();
      } else {
        // If profile picture already exists, show a confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Update Profile Picture?'),
            content: const Text('Do you want to update your profile picture?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _uploadProfileImage();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_newProfileImage != null && _currentUser != null) {
      try {
        final storageRef = FirebaseStorage.instance.ref();
        final profileImagesRef = storageRef.child('profile-pictures/${_currentUser!.uid}.jpg');

        // Upload the new profile picture
        final uploadTask = profileImagesRef.putFile(_newProfileImage!);
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the Firestore with new profile-url
        await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).update({
          'profile-url': downloadUrl,
        });

        setState(() {
          _profileUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );
      } catch (e) {
        debugPrint('Error uploading profile picture: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile picture')),
        );
      }
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF280F8F),
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFF72585),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 1),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: _profileUrl != null ? NetworkImage(_profileUrl!) : null,
                      backgroundColor: Colors.grey.shade200,
                      child: _profileUrl == null
                          ? const Icon(Icons.person, size: 65, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickProfileImage,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  _email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 15, // Set font size to 15
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Set button radius to 12
                    ),
                  ),
                ),
                const SizedBox(height: 220),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.login_outlined),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
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
