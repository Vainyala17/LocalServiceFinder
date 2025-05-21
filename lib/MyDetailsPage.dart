import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  // User data that can be edited
  Map<String, String> userData = {
    'firstName': 'John',
    'lastName': 'Doe',
    'title': 'Plumber',
    'email': 'johndoe@example.com',
    'phone': '+91 234 567 8900',
    'dob': '01/01/1990',
    'address': '123 Main Street',
    'city': 'Mumbai',
    'state': 'Maharashtra',
    'country': 'India',
    'aadhar': '1234 5678 9012',
    'latitude': '19.0760',
    'longitude': '72.8777',
    'locationName': 'Not set', // Current location name
  };

  // Track which field is currently being edited
  String? currentlyEditingField;
  final TextEditingController editingController = TextEditingController();

  // For profile image
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // For Google Maps
  GoogleMapController? mapController;
  LatLng _currentPosition = const LatLng(19.0760, 72.8777); // Default to Mumbai
  Set<Marker> _markers = {};
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    // Initialize current position from saved coordinates
    try {
      _currentPosition = LatLng(
          double.parse(userData['latitude'] ?? '19.0760'),
          double.parse(userData['longitude'] ?? '72.8777')
      );
      _updateMarkers();
    } catch (e) {
      print('Error initializing location: $e');
    }
  }

  // Update map markers
  void _updateMarkers() {
    _markers = {};
    _markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: _currentPosition,
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: userData['locationName'] ?? 'Current Location',
        ),
      ),
    );
  }
// Add this variable to your _MyDetailsPageState class at the top with other state variables
  bool _isEditing = false;

// Replace the existing _startEditing method with this one
  void _startEditing(String field, String currentValue) {
    setState(() {
      currentlyEditingField = field;
      editingController.text = currentValue;
    });
  }
  // Method to get current location
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          setState(() {
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are permanently denied, please enable in settings'),
          ),
        );
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark placemark = placemarks.first;
      String locationName = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}';

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        userData['latitude'] = position.latitude.toString();
        userData['longitude'] = position.longitude.toString();
        userData['locationName'] = locationName;
        userData['city'] = placemark.locality ?? userData['city']!;
        userData['state'] = placemark.administrativeArea ?? userData['state']!;
        userData['country'] = placemark.country ?? userData['country']!;
        _updateMarkers();
        _isLoadingLocation = false;
      });

      // Update map camera position
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentPosition,
              zoom: 15,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  // Show map in a dialog
  void _showMap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('My Location'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 15,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    backgroundColor: Colors.green.shade400,
                    child: _isLoadingLocation
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Icon(Icons.my_location, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Set as My Location'),
              onPressed: () {
                // Location already set when getting current location
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

  // Method to handle profile image selection
  Future<void> _handleProfileImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Photo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                if (_profileImage != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _profileImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.photo_library),
                      SizedBox(width: 10),
                      Text('Upload from Gallery'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImageFromGallery();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
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
                          decoration: const InputDecoration(labelText: 'First Name'),
                          controller: TextEditingController(text: userData['firstName']),
                          onChanged: (value) => userData['firstName'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Last Name'),
                          controller: TextEditingController(text: userData['lastName']),
                          onChanged: (value) => userData['lastName'] = value,
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
                              // Open new dialog after date selection
                              _showFullEditDialog(context);
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
                        TextField(
                          decoration: const InputDecoration(labelText: 'City'),
                          controller: TextEditingController(text: userData['city']),
                          onChanged: (value) => userData['city'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'State'),
                          controller: TextEditingController(text: userData['state']),
                          onChanged: (value) => userData['state'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Country'),
                          controller: TextEditingController(text: userData['country']),
                          onChanged: (value) => userData['country'] = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Aadhar Number'),
                          controller: TextEditingController(text: userData['aadhar']),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) => userData['aadhar'] = value,
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
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!) as ImageProvider
                              : null,
                          child: _profileImage == null
                              ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.green.shade300,
                          )
                              : null,
                        ),
                        Positioned(
                          right: -10,
                          bottom: -10,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.green.shade700,
                            ),
                            onPressed: _handleProfileImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Display full name from first and last name
                    currentlyEditingField == 'fullName'
                        ? _buildEditTextField('fullName')
                        : GestureDetector(
                      onTap: () => _startEditing('fullName',
                          userData['firstName']! + " " + userData['lastName']!),
                      child: Text(
                        userData['firstName']! + " " + userData['lastName']!,
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

                  // First Name field
                  _buildDirectlyEditableInfoItem(
                    Icons.person,
                    "First Name",
                    userData['firstName']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'firstName') {
                        _startEditing('firstName', userData['firstName']!);
                      }
                    },
                    TextInputType.name,
                    null,
                  ),

                  // Last Name field
                  _buildDirectlyEditableInfoItem(
                    Icons.person,
                    "Last Name",
                    userData['lastName']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'lastName') {
                        _startEditing('lastName', userData['lastName']!);
                      }
                    },
                    TextInputType.name,
                    null,
                  ),

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

                  // City field
                  _buildDirectlyEditableInfoItem(
                    Icons.location_city,
                    "City",
                    userData['city']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'city') {
                        _startEditing('city', userData['city']!);
                      }
                    },
                    TextInputType.text,
                    null,
                  ),

                  // State field
                  _buildDirectlyEditableInfoItem(
                    Icons.map,
                    "State",
                    userData['state']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'state') {
                        _startEditing('state', userData['state']!);
                      }
                    },
                    TextInputType.text,
                    null,
                  ),

                  // Country field
                  _buildDirectlyEditableInfoItem(
                    Icons.public,
                    "Country",
                    userData['country']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'country') {
                        _startEditing('country', userData['country']!);
                      }
                    },
                    TextInputType.text,
                    null,
                  ),

                  _buildSectionTitle("Identity Information", textColor),
                  const SizedBox(height: 12),

                  // Aadhar field
                  _buildDirectlyEditableInfoItem(
                    Icons.card_membership,
                    "Aadhar Number",
                    userData['aadhar']!,
                    textColor,
                    secondaryTextColor,
                        () {
                      if (currentlyEditingField != 'aadhar') {
                        _startEditing('aadhar', userData['aadhar']!);
                      }
                    },
                    TextInputType.number,
                    [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show full edit dialog again after date selection
  void _showFullEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'First Name'),
                controller: TextEditingController(text: userData['firstName']),
                onChanged: (value) => userData['firstName'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                controller: TextEditingController(text: userData['lastName']),
                onChanged: (value) => userData['lastName'] = value,
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
                  Navigator.of(context).pop();
                  _selectDate(context).then((_) {
                    _showFullEditDialog(context);
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
              TextField(
                decoration: const InputDecoration(labelText: 'City'),
                controller: TextEditingController(text: userData['city']),
                onChanged: (value) => userData['city'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'State'),
                controller: TextEditingController(text: userData['state']),
                onChanged: (value) => userData['state'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Country'),
                controller: TextEditingController(text: userData['country']),
                onChanged: (value) => userData['country'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Aadhar Number'),
                controller: TextEditingController(text: userData['aadhar']),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => userData['aadhar'] = value,
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
    String fieldKey = title.toLowerCase().replaceAll(' ', '');

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