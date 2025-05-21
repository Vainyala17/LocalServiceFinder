import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  // User data that can be edited
  Map<String, String> userData = {
    'name': 'John Doe',
    'title': 'Plumber',
    'email': 'johndoe@example.com',
    'phone': '+91 234 567 8900',
    'dob': '01/01/1990',
    'address': '123 Main Street, City, Country',
  };

  // Track which field is currently being edited
  String? currentlyEditingField;
  final TextEditingController editingController = TextEditingController();

  // Method to start editing a field
  void _startEditing(String field, String currentValue) {
    setState(() {
      currentlyEditingField = field;
      editingController.text = currentValue;
    });
  }

  // Method to save the edited value
  void _saveEdit() {
    if (currentlyEditingField != null) {
      setState(() {
        userData[currentlyEditingField!] = editingController.text;
        currentlyEditingField = null;
      });
    }
  }

  // Method to cancel editing
  void _cancelEdit() {
    setState(() {
      currentlyEditingField = null;
    });
  }

  // Method to clear the current text being edited
  void _clearText() {
    editingController.clear();
  }

  // Method to select date from calendar
  Future<void> _selectDate(BuildContext context) async {
    // Parse current date or use today's date if parsing fails
    DateTime initialDate;
    try {
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      initialDate = formatter.parse(userData['dob']!);
    } catch (e) {
      initialDate = DateTime.now().subtract(const Duration(days: 365 * 30)); // Default to 30 years ago
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade400,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      setState(() {
        userData['dob'] = formatter.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Show a dialog with all fields to edit at once
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Edit Profile'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          controller: TextEditingController(text: userData['name']),
                          onChanged: (value) => userData['name'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Title'),
                          controller: TextEditingController(text: userData['title']),
                          onChanged: (value) => userData['title'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          controller: TextEditingController(text: userData['email']),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => userData['email'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Phone'),
                          controller: TextEditingController(text: userData['phone']),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) => userData['phone'] = value,
                        ),
                        InkWell(
                          onTap: () {
                            // Close dialog temporarily to show date picker
                            Navigator.of(context).pop();
                            _selectDate(context).then((_) {
                              // Reopen dialog after date is selected
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Edit Profile'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Name'),
                                          controller: TextEditingController(text: userData['name']),
                                          onChanged: (value) => userData['name'] = value,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Title'),
                                          controller: TextEditingController(text: userData['title']),
                                          onChanged: (value) => userData['title'] = value,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Email'),
                                          controller: TextEditingController(text: userData['email']),
                                          keyboardType: TextInputType.emailAddress,
                                          onChanged: (value) => userData['email'] = value,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Phone'),
                                          controller: TextEditingController(text: userData['phone']),
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          onChanged: (value) => userData['phone'] = value,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Date of Birth'),
                                          controller: TextEditingController(text: userData['dob']),
                                          readOnly: true,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _selectDate(context);
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(labelText: 'Address'),
                                          controller: TextEditingController(text: userData['address']),
                                          onChanged: (value) => userData['address'] = value,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text('Save'),
                                      onPressed: () {
                                        setState(() {
                                          // All changes already applied via onChanged
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(labelText: 'Date of Birth'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(userData['dob']!),
                                const Icon(Icons.calendar_today, size: 16),
                              ],
                            ),
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Address'),
                          controller: TextEditingController(text: userData['address']),
                          onChanged: (value) => userData['address'] = value,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        setState(() {
                          // All changes already applied via onChanged
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header with avatar
            Container(
              color: Colors.green.shade400,
              padding: const EdgeInsets.only(bottom: 24),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.green.shade300,
                          ),
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.green.shade700,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Change profile picture')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    currentlyEditingField == 'name'
                        ? _buildEditTextField('name')
                        : GestureDetector(
                      onTap: () => _startEditing('name', userData['name']!),
                      child: Text(
                        userData['name']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    currentlyEditingField == 'title'
                        ? _buildEditTextField('title')
                        : GestureDetector(
                      onTap: () => _startEditing('title', userData['title']!),
                      child: Text(
                        userData['title']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Personal Information Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Personal Information", textColor),
                  const SizedBox(height: 12),

                  // Email field - directly editable
                  _buildDirectlyEditableInfoItem(
                    Icons.email,
                    "Email",
                    userData['email']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'email') {
                        _startEditing('email', userData['email']!);
                      }
                    },
                    TextInputType.emailAddress,
                    null,
                  ),

                  // Phone field - directly editable with number keyboard
                  _buildDirectlyEditableInfoItem(
                    Icons.phone,
                    "Phone",
                    userData['phone']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'phone') {
                        _startEditing('phone', userData['phone']!);
                      }
                    },
                    TextInputType.phone,
                    [FilteringTextInputFormatter.digitsOnly],
                  ),

                  // DOB field - with calendar picker
                  _buildDatePickerItem(
                    Icons.cake,
                    "Date of Birth",
                    userData['dob']!,
                    textColor,
                    secondaryTextColor,
                  ),

                  // Address field - directly editable
                  _buildDirectlyEditableInfoItem(
                    Icons.home,
                    "Address",
                    userData['address']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'address') {
                        _startEditing('address', userData['address']!);
                      }
                    },
                    TextInputType.streetAddress,
                    null,
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to handle editing text fields
  Widget _buildEditTextField(String field, {TextInputType? keyboardType, List<TextInputFormatter>? inputFormatters}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: editingController,
                autofocus: true,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter ${field.replaceAll('_', ' ')}',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: _clearText,
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: _saveEdit,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.green.shade200,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  // Directly editable info item - no edit icon
  Widget _buildDirectlyEditableInfoItem(
      IconData icon,
      String title,
      String value,
      Color textColor,
      Color secondaryTextColor,
      VoidCallback onTap,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      ) {
    String fieldKey = title.toLowerCase();

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.green.shade400, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // If we're currently editing this field, show text field
                    currentlyEditingField == fieldKey
                        ? _buildEditTextField(fieldKey, keyboardType: keyboardType, inputFormatters: inputFormatters)
                        : Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Special widget for date picker
  Widget _buildDatePickerItem(
      IconData icon,
      String title,
      String value,
      Color textColor,
      Color secondaryTextColor,
      ) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.green.shade400, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.calendar_today, color: Colors.green.shade300, size: 16),
            ],
          ),
        ),
      ),
    );
  }


}