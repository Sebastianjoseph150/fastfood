import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Terms & Conditions,',
            style: TextStyle(color: Colors.white)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Terms and Conditions',
              //   style: TextStyle(
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 16.0),
              Text(
                _termsAndConditionsText,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample terms and conditions text (replace this with your actual terms and conditions)
const String _termsAndConditionsText = '''
Welcome to [Your Food Delivery App]! These terms and conditions outline the rules and regulations for the use of our app.

By accessing this app, we assume you accept these terms and conditions in full. Do not continue to use [Your Food Delivery App] if you do not accept all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions:

"User," "You," and "Your" refer to you, the person accessing this app and accepting the Company’s terms and conditions.
"The Company," "Ourselves," "We," "Our," and "Us" refer to [Your Food Delivery App].

Use of the App:

The use of this app is subject to the following terms of use:
- The content of the pages of this app is for your general information and use only. It is subject to change without notice.
- Your use of any information or materials on this app is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services, or information available through this app meet your specific requirements.

Account Registration:

In order to use some features of the app, you may be required to create an account. You must provide accurate and complete information and keep your account information updated.
- You are responsible for maintaining the confidentiality of your account and password and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account or password.

Food Ordering and Delivery:

Our app provides a platform to order food items from various restaurants and delivers them to your provided location.
- We strive to provide accurate and up-to-date information regarding menu items, prices, and delivery times. However, we do not guarantee the accuracy of this information.
- The delivery times mentioned are estimates and can vary due to various factors, including but not limited to weather conditions and traffic.
- We are not responsible for the quality, safety, or availability of the food items provided by the restaurants.

Privacy Policy:

Our Privacy Policy details how we collect, use, and disclose information. By using the app, you agree to our Privacy Policy.

Intellectual Property:

The content, design, graphics, and logos contained in the app are the intellectual property of [Your Food Delivery App] and are protected by copyright laws.

Changes to Terms:

We reserve the right to modify these terms and conditions at any time without prior notice. Your continued use of the app after any changes to these terms will signify your acceptance of those changes.

Governing Law:

These terms and conditions are governed by and construed in accordance with the laws of [Your Country/State], and any disputes relating to these terms and conditions will be subject to the exclusive jurisdiction of the courts of [Your Country/State].

If you have any questions regarding these terms and conditions, please contact us at [Contact Information].
''';
