import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this dependency to pubspec.yaml

class HelpSupportPage extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final List<Map<String, dynamic>> faqItems = [
    {
      "question": "How do I book a service?",
      "answer": "You can book a service by selecting the desired category, choosing a service provider, and clicking 'Book Now'. Fill in the required details and confirm your booking.",
      "expanded": false,
    },
    {
      "question": "How can I cancel or reschedule my booking?",
      "answer": "Go to 'My Bookings' section, find your appointment, and select 'Cancel' or 'Reschedule'. You can reschedule up to 2 hours before the appointment time.",
      "expanded": false,
    },
    {
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit cards, debit cards, digital wallets (PayPal, Apple Pay, Google Pay), and cash payments upon service completion.",
      "expanded": false,
    },
    {
      "question": "How do I track my service provider?",
      "answer": "Once your booking is confirmed, you'll receive real-time updates and can track your service provider's location through the app's tracking feature.",
      "expanded": false,
    },
    {
      "question": "What if I'm not satisfied with the service?",
      "answer": "We offer a 100% satisfaction guarantee. If you're not happy with the service, contact us within 24 hours and we'll either send another provider or provide a full refund.",
      "expanded": false,
    },
    {
      "question": "Are your service providers verified?",
      "answer": "Yes, all our service providers are thoroughly background-checked, licensed, and insured. We verify their credentials and customer reviews before onboarding.",
      "expanded": false,
    },
    {
      "question": "How do I become a service provider?",
      "answer": "Download our Provider App, complete the registration process, submit required documents, and pass our verification process. We'll guide you through each step.",
      "expanded": false,
    },
    {
      "question": "What are your operating hours?",
      "answer": "Our customer support is available 24/7. Service availability varies by category - emergency services are available round the clock, while others operate from 6 AM to 10 PM.",
      "expanded": false,
    },
  ];

  final List<Map<String, dynamic>> contactOptions = [
    {
      "title": "Call Us",
      "subtitle": "Speak with our support team",
      "icon": Icons.phone,
      "color": Colors.green,
      "action": "tel:+1234567890",
    },
    {
      "title": "Email Support",
      "subtitle": "Send us your queries",
      "icon": Icons.email,
      "color": Colors.blue,
      "action": "mailto:support@serviceapp.com",
    },
    {
      "title": "Live Chat",
      "subtitle": "Chat with us in real-time",
      "icon": Icons.chat,
      "color": Colors.orange,
      "action": "chat",
    },
    {
      "title": "WhatsApp",
      "subtitle": "Message us on WhatsApp",
      "icon": Icons.message,
      "color": Colors.green.shade700,
      "action": "https://wa.me/1234567890",
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Report an Issue",
      "subtitle": "Having problems? Let us know",
      "icon": Icons.report_problem,
      "color": Colors.red,
    },
    {
      "title": "Rate Your Experience",
      "subtitle": "Help us improve our service",
      "icon": Icons.star_rate,
      "color": Colors.amber,
    },
    {
      "title": "Service Guidelines",
      "subtitle": "Terms and conditions",
      "icon": Icons.description,
      "color": Colors.purple,
    },
    {
      "title": "Privacy Policy",
      "subtitle": "How we protect your data",
      "icon": Icons.security,
      "color": Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? Colors.grey.shade900 : Colors.grey.shade50;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.support_agent, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We're here to assist you 24/7",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for help topics...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
            ),

            const SizedBox(height: 24),

            // Contact Options
            _buildSectionTitle("Contact Us", Icons.contact_support),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: contactOptions.length,
              itemBuilder: (context, index) {
                final option = contactOptions[index];
                return _buildContactCard(option);
              },
            ),

            const SizedBox(height: 24),

            // Quick Actions
            _buildSectionTitle("Quick Actions", Icons.flash_on),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: quickActions.length,
              itemBuilder: (context, index) {
                final action = quickActions[index];
                return _buildQuickActionCard(action);
              },
            ),

            const SizedBox(height: 24),

            // FAQ Section
            _buildSectionTitle("Frequently Asked Questions", Icons.help),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: faqItems.map((faq) => _buildFAQItem(faq)).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Emergency Contact
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Icon(Icons.emergency, size: 32, color: Colors.red.shade600),
                  const SizedBox(height: 8),
                  Text(
                    "Emergency Support",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "For urgent issues, call our emergency hotline",
                    style: TextStyle(color: Colors.red.shade600),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _launchURL("tel:+1234567890"),
                    icon: const Icon(Icons.phone),
                    label: const Text("Call Emergency"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // App Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "ServiceApp v1.0.0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "© 2024 ServiceApp. All rights reserved.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
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

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade600, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(Map<String, dynamic> option) {
    return InkWell(
      onTap: () {
        if (option["action"] == "chat") {
          _showChatDialog();
        } else {
          _launchURL(option["action"]);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              option["icon"],
              size: 32,
              color: option["color"],
            ),
            const SizedBox(height: 8),
            Text(
              option["title"],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              option["subtitle"],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return InkWell(
      onTap: () {
        _handleQuickAction(action["title"]);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              action["icon"],
              size: 32,
              color: action["color"],
            ),
            const SizedBox(height: 8),
            Text(
              action["title"],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              action["subtitle"],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ExpansionTile(
        title: Text(
          faq["question"],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq["answer"],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  void _showChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Live Chat"),
        content: const Text("Live chat feature will be available soon. Please use other contact methods for immediate assistance."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String actionTitle) {
    switch (actionTitle) {
      case "Report an Issue":
        _showReportIssueDialog();
        break;
      case "Rate Your Experience":
        _showRatingDialog();
        break;
      case "Service Guidelines":
        _showGuidelinesDialog();
        break;
      case "Privacy Policy":
        _showPrivacyPolicyDialog();
        break;
    }
  }

  void _showReportIssueDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report an Issue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Issue Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Describe the issue",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Issue reported successfully")),
              );
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rate Your Experience"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("How would you rate our service?"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) =>
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.star, color: Colors.amber, size: 32),
                  ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Thank you for your feedback!")),
              );
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _showGuidelinesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Service Guidelines"),
        content: const SingleChildScrollView(
          child: Text(
            "1. All services are provided by verified professionals\n"
                "2. Payment is due upon service completion\n"
                "3. Cancellation policy: 24 hours notice required\n"
                "4. Customer satisfaction is our priority\n"
                "5. Report any issues within 24 hours\n"
                "6. Respect service providers and their time\n"
                "7. Provide accurate service requirements\n"
                "8. Ensure safe access to service location",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Privacy Policy"),
        content: const SingleChildScrollView(
          child: Text(
            "We are committed to protecting your privacy. This policy explains how we collect, use, and protect your personal information.\n\n"
                "Information Collection:\n"
                "• Personal details for account creation\n"
                "• Service preferences and history\n"
                "• Location data for service delivery\n"
                "• Payment information (securely encrypted)\n\n"
                "Information Use:\n"
                "• Provide and improve our services\n"
                "• Process payments securely\n"
                "• Send service updates and notifications\n"
                "• Customer support communications\n\n"
                "Data Protection:\n"
                "• All data is encrypted and stored securely\n"
                "• No data is shared with third parties without consent\n"
                "• You can request data deletion at any time",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}