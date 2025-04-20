// import 'package:flutter/material.dart';
//
// import 'ChatPage.dart';
// import 'CustomBottomNavBar.dart';
//
// import 'ProfilePage.dart';
// import 'OrdersPage.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0; // Track selected tab
// // List of pages to navigate
//   final List<Widget> _pages = [
//     HomePage(),
//     OrdersPage(),
//     ChatPage(),
//     ProfilePage(),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update selected tab
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.greenAccent, // AppBar background color
//         titleSpacing: 17.0,
//         toolbarHeight: 60, // Set fixed height
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 40,
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: Colors.grey),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search....",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.notifications, color: Colors.black),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Promotional Banner
//             // Promotional Banner with Background Image
//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: DecorationImage(
//                   image: AssetImage('assets/Promo.png'), // <- path to your uploaded image
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               padding: EdgeInsets.all(16),
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Get 20% Off",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "on First Service!",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade400,
//                       borderRadius: BorderRadius.circular(20),
//
//                     ),
//                     child: Text(
//                       "Book Now",
//                       style: TextStyle(color: Colors.black,),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Service Categories
//             Text("Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: 6,
//               itemBuilder: (context, index) {
//                 List<Map<String, dynamic>> services = [
//                   {"icon": Icons.plumbing, "title": "Plumber"},
//                   {"icon": Icons.electrical_services, "title": "Electrician"},
//                   {"icon": Icons.format_paint, "title": "Painter"},
//                   {"icon": Icons.car_repair, "title": "Mechanic"},
//                   {"icon": Icons.cleaning_services, "title": "Cleaning"},
//                   {"icon": Icons.home_repair_service, "title": "Carpenter"},
//                 ];
//                 return Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.green.shade100,
//                       child: Icon(services[index]['icon'], size: 30, color: Colors.green.shade700),
//                     ),
//                     SizedBox(height: 5),
//                     Text(services[index]['title'], style: TextStyle(fontSize: 14)),
//                   ],
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//
//             // Popular Services
//             Text("Popular Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             SizedBox(
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: 200,
//                     margin: EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.greenAccent,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Popular Service ${index + 1}",
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'OrdersPage.dart';
import 'ProfilePage.dart';
import 'HomeMainPage.dart';
import 'CustomBottomNavBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeMainPage(),
    OrdersPage(),
    ChatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        titleSpacing: 17.0,
        toolbarHeight: 60,
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search....",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: _pages[_selectedIndex], // ← Swaps between Home, Orders, Chat, Profile
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
