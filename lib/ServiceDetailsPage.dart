import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatefulWidget {
  final Map<String, dynamic> serviceData;
  final Function(bool) onSelectionChanged;

  const ServiceDetailsPage({
    Key? key,
    required this.serviceData,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _ServiceDetailsPageState createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.serviceData["selected"];
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.serviceData["details"];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(widget.serviceData["name"]),
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green.shade700),
        titleTextStyle: TextStyle(
          color: Colors.green.shade700,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.green.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    widget.serviceData["icon"] as IconData,
                    size: 60,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.serviceData["name"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.serviceData["description"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Service Information Cards
            _buildInfoCard("Why Call Us?", details["why_call"], Icons.help_outline),
            _buildInfoCard("When to Call", details["when_to_call"], Icons.schedule),
            _buildInfoCard("What Happens", details["what_happens"], Icons.build),
            _buildInfoCard("Where Available", details["where_available"], Icons.location_on),
            _buildInfoCard("Average Cost", details["average_cost"], Icons.attach_money),
            _buildInfoCard("Response Time", details["response_time"], Icons.timer),

            // Services Included
            Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.checklist, color: Colors.green.shade700, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Services Included",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...details["services_included"].map<Widget>((service) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                service,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                      widget.onSelectionChanged(isSelected);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${widget.serviceData["name"]} ${isSelected ? "added to" : "removed from"} your services'
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(isSelected ? Icons.remove : Icons.add),
                    label: Text(isSelected ? "Remove Service" : "Add Service"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.red.shade400 : Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add booking functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking ${widget.serviceData["name"]} service...'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Book Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green.shade700, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}