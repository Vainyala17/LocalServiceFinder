import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final Color textColor = Colors.black;
  final Color secondaryTextColor = Colors.grey.shade600;

  List<Map<String, dynamic>> serviceCategories = [
    {"name": "Plumbing", "icon": Icons.plumbing, "selected": true},
    {"name": "Electrical", "icon": Icons.electrical_services, "selected": false},
    {"name": "Carpentry", "icon": Icons.handyman, "selected": false},
    {"name": "Cleaning", "icon": Icons.cleaning_services, "selected": true},
    {"name": "Painting", "icon": Icons.format_paint, "selected": false},
    {"name": "Gardening", "icon": Icons.yard, "selected": true},
  ];

  List<Map<String, dynamic>> serviceAreas = [
    {"name": "Downtown", "radius": "3 miles", "active": true},
    {"name": "North Side", "radius": "5 miles", "active": true},
    {"name": "South Bay", "radius": "7 miles", "active": false},
  ];

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo Banner
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/Promo.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Get 20% Off", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("on First Service!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Book Now", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Service Grid
          // Text("Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // SizedBox(height: 10),
          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //   ),
          //   itemCount: 6,
          //   itemBuilder: (context, index) {
          //     List<Map<String, dynamic>> services = [
          //       {"icon": Icons.plumbing, "title": "Plumber"},
          //       {"icon": Icons.electrical_services, "title": "Electrician"},
          //       {"icon": Icons.format_paint, "title": "Painter"},
          //       {"icon": Icons.car_repair, "title": "Mechanic"},
          //       {"icon": Icons.cleaning_services, "title": "Cleaning"},
          //       {"icon": Icons.home_repair_service, "title": "Carpenter"},
          //     ];
          //     return Column(
          //       children: [
          //         CircleAvatar(
          //           radius: 30,
          //           backgroundColor: Colors.green.shade100,
          //           child: Icon(services[index]['icon'], size: 30, color: Colors.green.shade400),
          //         ),
          //         SizedBox(height: 5),
          //         Text(services[index]['title'], style: TextStyle(fontSize: 14)),
          //       ],
          //     );
          //   },
          // ),
          const SizedBox(height: 24),
          _buildSectionTitle("Service Information", textColor),
          const SizedBox(height: 12),
          _buildServiceCategories(),
          const SizedBox(height: 24),
          _buildSectionTitle("Service Areas", textColor),
          const SizedBox(height: 12),
          _buildServiceAreas(),

          const SizedBox(height: 24),
          _buildSectionTitle("Service Pricing", textColor),
          const SizedBox(height: 12),
          _buildServicePricing(textColor, secondaryTextColor),

          const SizedBox(height: 24),
          _buildSectionTitle("Availability", textColor),
          const SizedBox(height: 12),
          _buildAvailabilitySettings(textColor, secondaryTextColor),
          SizedBox(height: 20),

          // Popular Services
          Text("Popular Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Popular Service ${index + 1}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildServiceCategories() {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: serviceCategories.map((category) {
        return InkWell(
          onTap: () {
            // Toggle selection
            setState(() {
              category["selected"] = !category["selected"];
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '${category["name"]} ${category["selected"] ? "added to" : "removed from"} services'
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50) / 3,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: category["selected"] ? Colors.green.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: category["selected"] ? Colors.green.shade400 : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category["icon"] as IconData,
                  color: category["selected"] ? Colors.green.shade700 : Colors.grey.shade700,
                  size: 28,
                ),
                const SizedBox(height: 6),
                Text(
                  category["name"] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: category["selected"] ? Colors.green.shade700 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildServiceAreas() {
    return Column(
      children: serviceAreas.map((area) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: area["active"] ? Colors.green.shade200 : Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: SwitchListTile(
            title: Text(
              area["name"] as String,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Service radius: ${area["radius"]}"),
            value: area["active"] as bool,
            activeColor: Colors.green.shade400,
            onChanged: (bool value) {
              setState(() {
                area["active"] = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${area["name"]} ${value ? "activated" : "deactivated"}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            secondary: Icon(
              Icons.location_on,
              color: area["active"] ? Colors.green.shade400 : Colors.grey.shade400,
            ),
          ),
        );
      }).toList(),
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

  Widget _buildServicePricing(Color textColor, Color secondaryTextColor) {
    List<Map<String, dynamic>> pricingOptions = [
      {
        "title": "Basic Plumbing Service",
        "price": "\$50",
        "unit": "per hour",
        "description": "Standard plumbing repairs and installations"
      },
      {
        "title": "Emergency Service",
        "price": "\$85",
        "unit": "per hour",
        "description": "Available for urgent issues 24/7"
      },
      {
        "title": "Home Inspection",
        "price": "\$120",
        "unit": "fixed price",
        "description": "Complete plumbing system inspection"
      },
    ];

    return Column(
      children: pricingOptions.map((option) {
        return Card(
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.green.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option["title"] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option["description"] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      option["price"] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    Text(
                      option["unit"] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAvailabilitySettings(Color textColor, Color secondaryTextColor) {
    Map<String, bool> weekdays = {
      "Monday": true,
      "Tuesday": true,
      "Wednesday": true,
      "Thursday": true,
      "Friday": true,
      "Saturday": false,
      "Sunday": false,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Working hours
        Card(
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.green.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Working Hours",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Start Time",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Show time picker
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Set start time')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "9:00 AM",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "End Time",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Show time picker
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Set end time')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "5:00 PM",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Working days
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.green.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Working Days",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...weekdays.entries.map((entry) {
                  return SwitchListTile(
                    title: Text(entry.key),
                    value: entry.value,
                    activeColor: Colors.green.shade400,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (bool value) {
                      setState(() {
                        weekdays[entry.key] = value;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
