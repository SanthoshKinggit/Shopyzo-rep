// Suggested code may be subject to a license. Learn more: ~LicenseLog:379606062.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1451730466.
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_field, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, unused_import, avoid_print, unused_element, unnecessary_const

import 'package:flutter/services.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/log.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/mainpages/splashscreen.dart';
import 'package:myapp/mainpages/step.dart';
import 'package:flutter/material.dart';

class UserTypeSelection extends StatefulWidget {
  const UserTypeSelection({super.key});

  @override
  _UserTypeSelectionState createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = -1;

  final List<UserTypeItem> _userTypes = [
    UserTypeItem(
      title: 'Customer',
      icon: Icons.person,
      description: 'Browse and purchase products',
      backgroundColor: const Color(0xFF6FA3EF),
      iconColor: Colors.white,
      destination: RegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
    UserTypeItem(
      title: 'Vendor',
      icon: Icons.storefront,
      description: 'Sell products and manage',
      backgroundColor: const Color.fromARGB(255, 58, 182, 87),
      iconColor: Colors.white,
      destination: VendorRegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
    UserTypeItem(
      title: 'Franchis',
      icon: Icons.business_center,
      description: 'Manage and expand network',
      backgroundColor: const Color.fromARGB(255, 207, 157, 40),
      iconColor: Colors.white,
      destination: FranchiseeRegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToDestination(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              _userTypes[index].destination,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  Widget _buildUserTypeCard(int index) {
    final userType = _userTypes[index];
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateToDestination(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              userType.backgroundColor,
              userType.backgroundColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: userType.backgroundColor.withOpacity(0.5),
              blurRadius: isSelected ? 30 : 10,
              offset: const Offset(0, 10),
            ),
          ],
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 3,
                )
              : Border.all(
                  color: Colors.transparent,
                ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected ? 60 : 50,
              width: isSelected ? 60 : 50,
              decoration: BoxDecoration(
                color: userType.iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                userType.icon,
                color: userType.iconColor,
                size: isSelected ? 32 : 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userType.title,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: isSelected ? 20 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userType.description,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text(
                'Choose Your Role',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Select one to proceed further',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _userTypes.length,
                  itemBuilder: (context, index) {
                    return _buildUserTypeCard(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTypeItem {
  final String title;
  final IconData icon;
  final String description;
  final Color backgroundColor;
  final Color iconColor;
  final Widget destination;
  final String fontFamily;
  final double iconSize;

  UserTypeItem({
    required this.title,
    required this.icon,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
    required this.destination,
    required this.fontFamily,
    required this.iconSize,
  });
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextInputFormatter? inputFormatter;
  final String Function(String?) validator;
  final int? maxLines;

  CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    required this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
      validator: validator,
      maxLines: maxLines,
    );
  }
}


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> with SingleTickerProviderStateMixin {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Tab Controller
  late TabController _tabController;

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  // Focus Nodes
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  // Dropdown Values
  String? _educationLevel;
  String? _incomeRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      // Collect all form data
      final registrationData = {
        'Personal': {
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        },
        'Contact': {
          'address': _addressController.text,
          'city': _cityController.text,
          'state': _stateController.text,
        },
        'Additional': {
          'educationLevel': _educationLevel,
          'incomeRange': _incomeRange,
        }
      };

      // TODO: Implement actual submission logic (e.g., API call)
      print('Registration Data: $registrationData');
      
      // Show success dialog or navigate to next screen
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful'),
        content: const Text('Your registration has been submitted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Registration Form',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4A6CF7),
      ),
      body: Row(
        children: [
          Container(
            width: 70,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildVerticalTab(Icons.person, "Personal", 0),
                _buildVerticalTab(Icons.contact_mail, "Contact", 1),
                _buildVerticalTab(Icons.details, "Additional", 2),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPersonalDetailsTab(),
                  _buildContactDetailsTab(),
                  _buildAdditionalDetailsTab(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 44.0),
        child: Center(
          child: SizedBox(
            height: 60,
            width: 300,
            child: ElevatedButton(
              onPressed: _submitRegistration,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A6CF7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
              ),
              child: const Text(
                'Submit Registration',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalTab(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: _tabController.index == index
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _tabController.index == index
                  ? Colors.white
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _tabController.index == index
                    ? Colors.white
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: _tabController.index == index
                    ? const Color(0xFF4A6CF7)
                    : const Color.fromARGB(255, 117, 117, 117),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Personal Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _nameController,
            labelText: 'Full Name',
            prefixIcon: Icons.person,
            focusNode: _nameFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            labelText: 'Email Address',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            labelText: 'Phone Number',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            focusNode: _phoneFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              final phoneRegex = RegExp(r'^\d{10}$');
              if (!phoneRegex.hasMatch(value)) {
                return 'Please enter a valid 10-digit phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Contact Details'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _addressController,
            labelText: 'Full Address',
            prefixIcon: Icons.location_on,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _cityController,
            labelText: 'City',
            prefixIcon: Icons.location_city,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _stateController,
            labelText: 'State',
            prefixIcon: Icons.map,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your state';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional Information'),
          const SizedBox(height: 16),
          _buildDropdownField(
            value: _educationLevel,
            labelText: 'Education Level',
            items: const [
              'High School',
              'Graduate',
              'Post Graduate',
              'Professional Degree',
            ],
            onChanged: (value) {
              setState(() {
                _educationLevel = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select an education level';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            value: _incomeRange,
            labelText: 'Income Range',
            items: const [
              'Below 2,00,000',
              '2,00,000 - 5,00,000',
              '5,00,000 - 10,00,000',
              'Above 10,00,000',
            ],
            onChanged: (value) {
              setState(() {
                _incomeRange = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select an income range';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4A6CF7),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF4A6CF7)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF4A6CF7),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required List<String> items,
    String? value,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text('Select $labelText'),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color(0xFF4A6CF7),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey[600],
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class VendorRegistrationForm extends StatefulWidget {
  @override
  _VendorRegistrationFormState createState() => _VendorRegistrationFormState();
}

class _VendorRegistrationFormState extends State<VendorRegistrationForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers for Vendor Details
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _businessNameController.dispose();
    _gstController.dispose();
    _panController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Vendor Registration Form',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 182, 87),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical Tabs
          SizedBox(
            width: 70,
            child: Column(
              children: [
                _buildVerticalTab(Icons.business, "Business", 0),
                _buildVerticalTab(Icons.contact_mail, "Contact", 1),
                _buildVerticalTab(Icons.details, "Details", 2),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBusinessDetailsTab(),
                  _buildContactDetailsTab(),
                  _buildAdditionalDetailsTab(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 44.0),
        child: SizedBox(
          height: 60,
          width: 300,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 58, 182, 87),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
            ),
            child: Text(
              'Submit Registration',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Vertical Tab
  Widget _buildVerticalTab(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: _tabController.index == index
                  ? const Color.fromARGB(255, 255, 255,
                      255) // Highlight active tab with background color
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(32)),
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _tabController.index == index
                    ? Colors.white
                    : Colors.transparent, // Change circle color on active tab
                shape: BoxShape.circle,
                border: Border.all(
                  color: _tabController.index == index
                      ? Colors.white
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 24,
                  color: _tabController.index == index
                      ? const Color.fromARGB(255, 58, 182, 87)
                      : const Color.fromARGB(255, 117, 117,
                          117), // Change icon color for active tab
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Business Details Tab
  Widget _buildBusinessDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Business Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _businessNameController,
            labelText: 'Business Name',
            prefixIcon: Icons.business,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _gstController,
            labelText: 'GST Number',
            prefixIcon: Icons.receipt_long,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _panController,
            labelText: 'PAN Number',
            prefixIcon: Icons.article,
          ),
        ],
      ),
    );
  }

  // Contact Details Tab
  Widget _buildContactDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Contact Details'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            labelText: 'Email Address',
            prefixIcon: Icons.email,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            labelText: 'Phone Number',
            prefixIcon: Icons.phone,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _addressController,
            labelText: 'Address',
            prefixIcon: Icons.location_on,
          ),
        ],
      ),
    );
  }

  // Additional Details Tab
  Widget _buildAdditionalDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _cityController,
            labelText: 'City',
            prefixIcon: Icons.location_city,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _stateController,
            labelText: 'State',
            prefixIcon: Icons.map,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _pinCodeController,
            labelText: 'Pin Code',
            prefixIcon: Icons.pin,
          ),
        ],
      ),
    );
  }

  // Reusable Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 58, 182, 87),
      ),
    );
  }

  // Reusable Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon:
            Icon(prefixIcon, color: const Color.fromARGB(255, 58, 182, 87)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: const Color.fromARGB(255, 58, 182, 87),
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class FranchiseeRegistrationForm extends StatefulWidget {
  @override
  _FranchiseeRegistrationFormState createState() =>
      _FranchiseeRegistrationFormState();
}

class _FranchiseeRegistrationFormState extends State<FranchiseeRegistrationForm>
    with SingleTickerProviderStateMixin {
  // Tab Controller
  late TabController _tabController;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers for Franchisee Details
  final TextEditingController _franchiseeNameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _taxIdController = TextEditingController();

  // Focus Nodes for Accessibility
  final FocusNode _franchiseeNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _franchiseeNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    _taxIdController.dispose();
    _franchiseeNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Franchis Registration',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 228, 160, 0),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Tabs
          SizedBox(
            width: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 6),
              child: Column(
                children: [
                  _buildVerticalTab(Icons.person, "Personal", 0),
                  _buildVerticalTab(Icons.business, "Business", 1),
                  _buildVerticalTab(Icons.payment, "Tax Details", 2),
                ],
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPersonalDetailsTab(),
                  _buildBusinessDetailsTab(),
                  _buildTaxDetailsTab(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 44.0),
        child: SizedBox(
          height: 60,
          width: 300,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 228, 160, 0),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
            ),
            child: Text(
              'Submit Registration',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Vertical Tab Builder
  Widget _buildVerticalTab(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: _tabController.index == index
              ? Color.fromARGB(255, 255, 255, 255)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _tabController.index == index
                  ? Colors.white
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _tabController.index == index
                    ? Colors.white
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: _tabController.index == index
                    ? const Color.fromARGB(255, 228, 160, 0)
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Personal Details Tab
  Widget _buildPersonalDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Personal Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _franchiseeNameController,
            labelText: 'Franchis Name',
            prefixIcon: Icons.person,
            focusNode: _franchiseeNameFocusNode,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            labelText: 'Email Address',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            labelText: 'Phone Number',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            focusNode: _phoneFocusNode,
          ),
        ],
      ),
    );
  }

  // Business Details Tab
  Widget _buildBusinessDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Business Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _businessNameController,
            labelText: 'Business Name',
            prefixIcon: Icons.business,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _addressController,
            labelText: 'Business Address',
            prefixIcon: Icons.location_on,
          ),
        ],
      ),
    );
  }

  // Tax Details Tab
  Widget _buildTaxDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Tax Information'),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _taxIdController,
            labelText: 'Tax ID',
            prefixIcon: Icons.payment,
          ),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 228, 160, 0)),
    );
  }

  // Reusable Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
          color: const Color.fromARGB(255, 228, 160, 0),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: const Color.fromARGB(255, 228, 160, 0),
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
