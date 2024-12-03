// // ignore_for_file: unused_element

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:myapp/homepage.dart';
// import 'package:myapp/others/prime.dart';

// abstract class _PaymentAppState extends State<PaymentApp> {
//   late PageController _pageController;
//   Timer? _timer;
//   int _currentPage = 0;

//   // List of image paths
//   final List<String> imagePaths = [
//     'assets/logo/0119b7454430bb9b203d3c6b113f5e21.png',
//     'assets/logo/banners3.png',
//     'assets/logo/banners2.png',
//     'assets/logo/22bb2.png',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       initialPage: 0,
//       viewportFraction: 0.85, // This will show a bit of next/previous images
//     );
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < imagePaths.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   // Replace your existing SingleChildScrollView with this Widget
//   Widget _buildImageCarousel() {
//     return Column(
//       children: [
//         Container(
//           height: 160,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (int page) {
//               setState(() {
//                 _currentPage = page;
//               });
//             },
//             itemCount: imagePaths.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.asset(
//                     imagePaths[index],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         // Page Indicator
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             imagePaths.length,
//             (index) => Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _currentPage == index
//                     ? primary
//                     : Colors.grey.shade300,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';


class Login2Screen extends StatefulWidget {
  const Login2Screen({Key? key}) : super(key: key);

  @override
  State<Login2Screen> createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              const Color(0xFFFAD961),
              const Color(0xFFFAD961).withOpacity(0.7),
              const Color(0xFF0A1F44),
            ],
            stops: const [0.0, 0.4, 0.4],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome back to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Doxa•Wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                // Circle with logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png', // Add your logo image here
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Please login to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                // Email TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'email@address.com',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF0A1F44),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Password TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: '• • • • • • • •',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFF0A1F44),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF0A1F44),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Sign In Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAD961),
                    foregroundColor: const Color(0xFF0A1F44),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Create Account Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Create one',
                        style: TextStyle(
                          color: Color(0xFFFAD961),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}