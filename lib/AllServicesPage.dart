
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ServiceDetailsPage.dart';

class AllServicesPage extends StatelessWidget {
  final List<Map<String, dynamic>> allServices;
  final Function(int, bool) onServiceSelectionChanged;

  const AllServicesPage({
    Key? key,
    required this.allServices,
    required this.onServiceSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Services"),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green.shade700),
        titleTextStyle: TextStyle(
          color: Colors.green.shade700,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: allServices.length,
          itemBuilder: (context, index) {
            final service = allServices[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsPage(
                      serviceData: service,
                      onSelectionChanged: (isSelected) {
                        onServiceSelectionChanged(index, isSelected);
                      },
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: service["selected"] ? Colors.green.shade50 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: service["selected"] ? Colors.green.shade300 : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service["icon"] as IconData,
                      size: 48,
                      color: service["selected"] ? Colors.green.shade700 : Colors.grey.shade600,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      service["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: service["selected"] ? Colors.green.shade700 : Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service["description"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: service["selected"] ? Colors.green.shade600 : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        service["selected"] ? "Selected" : "Available",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}