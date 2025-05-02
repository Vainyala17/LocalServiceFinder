import 'package:flutter/material.dart';

class HomeMainPage extends StatelessWidget {
  @override
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
          Text("Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              List<Map<String, dynamic>> services = [
                {"icon": Icons.plumbing, "title": "Plumber"},
                {"icon": Icons.electrical_services, "title": "Electrician"},
                {"icon": Icons.format_paint, "title": "Painter"},
                {"icon": Icons.car_repair, "title": "Mechanic"},
                {"icon": Icons.cleaning_services, "title": "Cleaning"},
                {"icon": Icons.home_repair_service, "title": "Carpenter"},
              ];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green.shade100,
                    child: Icon(services[index]['icon'], size: 30, color: Colors.green.shade400),
                  ),
                  SizedBox(height: 5),
                  Text(services[index]['title'], style: TextStyle(fontSize: 14)),
                ],
              );
            },
          ),
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
}
