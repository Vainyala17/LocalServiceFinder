import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: _buildFavouritesList(),
    );
  }

  Widget _buildFavouritesList() {
    List<FavouriteService> favourites = _getFavouriteServices();

    if (favourites.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          // Refresh favourites
        });
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          return _buildFavouriteCard(favourites[index]);
        },
      ),
    );
  }

  Widget _buildFavouriteCard(FavouriteService service) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: service.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    service.icon,
                    color: service.color,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        service.category,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '${service.rating}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '(${service.reviewCount} reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red[400],
                  ),
                  onPressed: () => _removeFavourite(service),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              service.description,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Starting from ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$${service.startingPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green[700],
                  ),
                ),
                Spacer(),
                OutlinedButton(
                  onPressed: () => _bookService(service),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[600],
                    side: BorderSide(color: Colors.blue[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No Favourites Yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Services you mark as favourite\nwill appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              height: 1.4,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to services page
              _exploreServices();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Explore Services'),
          ),
        ],
      ),
    );
  }

  List<FavouriteService> _getFavouriteServices() {
    // Mock data - replace with actual API call or local storage
    return [
      FavouriteService(
        id: '1',
        name: 'House Cleaning',
        category: 'Home Services',
        description: 'Professional house cleaning service with eco-friendly products. Deep cleaning available.',
        startingPrice: 50.0,
        rating: 4.8,
        reviewCount: 245,
        icon: Icons.cleaning_services,
        color: Colors.blue,
      ),
      FavouriteService(
        id: '2',
        name: 'Plumbing Repair',
        category: 'Home Maintenance',
        description: 'Emergency plumbing services, pipe repairs, and installation by certified professionals.',
        startingPrice: 75.0,
        rating: 4.6,
        reviewCount: 132,
        icon: Icons.plumbing,
        color: Colors.orange,
      ),
      FavouriteService(
        id: '3',
        name: 'Garden Maintenance',
        category: 'Outdoor Services',
        description: 'Complete garden care including lawn mowing, pruning, and landscape maintenance.',
        startingPrice: 60.0,
        rating: 4.7,
        reviewCount: 89,
        icon: Icons.grass,
        color: Colors.green,
      ),
    ];
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Favourites'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Search services...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            // Implement search logic
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  void _removeFavourite(FavouriteService service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Favourite'),
        content: Text('Remove "${service.name}" from favourites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed from favourites')),
              );
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _bookService(FavouriteService service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking ${service.name}...')),
    );
  }

  void _exploreServices() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to services...')),
    );
  }
}

class FavouriteService {
  final String id;
  final String name;
  final String category;
  final String description;
  final double startingPrice;
  final double rating;
  final int reviewCount;
  final IconData icon;
  final Color color;

  FavouriteService({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.startingPrice,
    required this.rating,
    required this.reviewCount,
    required this.icon,
    required this.color,
  });
}