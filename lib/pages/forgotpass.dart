// ignore_for_file: unused_field, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:myapp/pages/login.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _otp = '';
  String _newPassword = '';
  String _confirmPassword = '';
  bool _showOTPField = false;

  void _sendOTP() {
    if (_formKey.currentState!.validate()) {
      // Implement your OTP sending logic here
      // For example, call an API to send an OTP to the user's mobile number
      print('Sending OTP to mobile number: $_mobileNumber');
      setState(() {
        _showOTPField = true;
      });
    }
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Implement your password reset logic here
      // For example, call an API to update the user's password
      print('Resetting password with OTP: $_otp, new password: $_newPassword');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                onSaved: (value) => _mobileNumber = value!,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _sendOTP,
                child: Text('Send OTP'),
              ),
              if (_showOTPField)
                Column(
                  children: [
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the OTP';
                        }
                        return null;
                      },
                      onSaved: (value) => _otp = value!,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a new password';
                        }
                        return null;
                      },
                      onSaved: (value) => _newPassword = value!,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _newPassword) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) => _confirmPassword = value!,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _resetPassword,
                      child: Text('Submit'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}