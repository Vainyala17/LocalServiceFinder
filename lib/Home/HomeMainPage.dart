import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../AllServicesPage.dart';
import '../ServiceDetailsPage.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final Color textColor = Colors.black;
  final Color secondaryTextColor = Colors.grey.shade600;

  List<Map<String, dynamic>> serviceCategories = [
    {
      "name": "Plumbing",
      "icon": Icons.plumbing,
      "selected": true,
      "description": "Professional plumbing services for your home and office",
      "details": {
        "why_call": "For water leaks, pipe repairs, fixture installations, and drainage issues",
        "when_to_call": "Immediately for emergencies like burst pipes or major leaks. Schedule during business hours for routine maintenance",
        "what_happens": "Licensed plumber will diagnose the issue, provide estimate, and complete repairs using quality materials",
        "where_available": "Available citywide with 24/7 emergency service",
        "average_cost": "\$80-200 per hour",
        "response_time": "Emergency: 30-60 minutes, Regular: Same day",
        "services_included": [
          "Leak detection and repair",
          "Pipe installation and replacement",
          "Drain cleaning and unclogging",
          "Fixture installation (sinks, toilets, faucets)",
          "Water heater repair and installation",
          "Emergency plumbing services"
        ]
      }
    },
    {
      "name": "Electrical",
      "icon": Icons.electrical_services,
      "selected": false,
      "description": "Certified electrical services for safe and reliable power solutions",
      "details": {
        "why_call": "For electrical installations, repairs, power outages, and safety inspections",
        "when_to_call": "Immediately for electrical emergencies, sparks, or power failures. Schedule for installations and upgrades",
        "what_happens": "Licensed electrician will assess electrical systems, ensure safety compliance, and complete work to code",
        "where_available": "Service all residential and commercial areas with emergency support",
        "average_cost": "\$100-250 per hour",
        "response_time": "Emergency: 45 minutes, Regular: 1-2 days",
        "services_included": [
          "Electrical panel upgrades",
          "Outlet and switch installation",
          "Lighting installation and repair",
          "Wiring and rewiring services",
          "Electrical safety inspections",
          "Generator installation"
        ]
      }
    },
    {
      "name": "Carpentry",
      "icon": Icons.handyman,
      "selected": false,
      "description": "Skilled carpentry services for construction and repair needs",
      "details": {
        "why_call": "For custom woodwork, repairs, installations, and construction projects",
        "when_to_call": "Schedule during business hours for consultations and project planning",
        "what_happens": "Experienced carpenter will assess project, provide detailed quote, and execute work with precision",
        "where_available": "Serving all areas with workshop facilities for custom projects",
        "average_cost": "\$50-120 per hour",
        "response_time": "Consultation: 1-3 days, Project start: 3-7 days",
        "services_included": [
          "Custom furniture and cabinetry",
          "Door and window installation",
          "Deck and patio construction",
          "Trim and molding installation",
          "Furniture repair and restoration",
          "Built-in storage solutions"
        ]
      }
    },
    {
      "name": "Cleaning",
      "icon": Icons.cleaning_services,
      "selected": true,
      "description": "Professional cleaning services for homes and offices",
      "details": {
        "why_call": "For regular maintenance, deep cleaning, move-in/out cleaning, and special events",
        "when_to_call": "Schedule weekly, bi-weekly, monthly, or one-time services based on your needs",
        "what_happens": "Professional cleaning team arrives with supplies, follows checklist, and ensures thorough cleaning",
        "where_available": "Serving all residential and commercial areas with flexible scheduling",
        "average_cost": "\$25-50 per hour per cleaner",
        "response_time": "Same day for urgent needs, 1-3 days for regular booking",
        "services_included": [
          "Regular house cleaning",
          "Deep cleaning services",
          "Office and commercial cleaning",
          "Move-in/move-out cleaning",
          "Post-construction cleanup",
          "Carpet and upholstery cleaning"
        ]
      }
    },
    {
      "name": "Painting",
      "icon": Icons.format_paint,
      "selected": false,
      "description": "Professional painting services for interior and exterior projects",
      "details": {
        "why_call": "For home improvement, property maintenance, color changes, and protection from elements",
        "when_to_call": "Spring and fall are ideal for exterior work, interior painting available year-round",
        "what_happens": "Professional painters prep surfaces, protect furniture, apply quality paint, and clean up thoroughly",
        "where_available": "Full coverage area with weather-dependent exterior scheduling",
        "average_cost": "\$2-6 per square foot",
        "response_time": "Estimate: 1-2 days, Project start: 3-10 days",
        "services_included": [
          "Interior wall and ceiling painting",
          "Exterior house painting",
          "Cabinet and furniture painting",
          "Pressure washing and prep work",
          "Color consultation",
          "Wallpaper removal and installation"
        ]
      }
    },
    {
      "name": "Gardening",
      "icon": Icons.yard,
      "selected": true,
      "description": "Expert gardening and landscaping services for beautiful outdoor spaces",
      "details": {
        "why_call": "For lawn maintenance, landscape design, plant care, and seasonal garden preparation",
        "when_to_call": "Spring for planting, regular maintenance throughout growing season, fall for cleanup",
        "what_happens": "Certified landscapers assess your space, create maintenance plan, and provide ongoing care",
        "where_available": "All residential areas with seasonal service adjustments",
        "average_cost": "\$40-80 per hour",
        "response_time": "Regular service: 1-3 days, Design consultation: 3-5 days",
        "services_included": [
          "Lawn mowing and maintenance",
          "Landscape design and installation",
          "Tree and shrub pruning",
          "Seasonal planting and cleanup",
          "Irrigation system installation",
          "Garden pest and disease management"
        ]
      }
    },
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
        ],
      ),
    );
  }
  Widget _buildServiceCategories() {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: serviceCategories.take(6).map((category) {
            return InkWell(
              onTap: () {
                // Navigate to service details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsPage(
                      serviceData: category,
                      onSelectionChanged: (isSelected) {
                        setState(() {
                          category["selected"] = isSelected;
                        });
                      },
                    ),
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
        ),
        const SizedBox(height: 16),
        // See All Services Button
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllServicesPage(
                  allServices: serviceCategories,
                  onServiceSelectionChanged: (index, isSelected) {
                    setState(() {
                      serviceCategories[index]["selected"] = isSelected;
                    });
                  },
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grid_view, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  "See All Services",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, color: Colors.green.shade700, size: 16),
              ],
            ),
          ),
        ),
      ],
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
