import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
        textColor: Colors.white,
        hasLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update your details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                label: "Full Name",
                hintText: "Enter your full name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                label: "Email",
                hintText: "Enter your email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                label: "Phone Number",
                hintText: "Enter your phone number",
                icon: Icons.phone_outlined,
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                label: "Address",
                hintText: "Enter your address",
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 32.0),
              CustomButton(title: "Save Changes", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
