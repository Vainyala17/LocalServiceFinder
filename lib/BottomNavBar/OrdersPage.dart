import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[600],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue[600],
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList('active'),
          _buildOrdersList('completed'),
          _buildOrdersList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String status) {
    List<Order> orders = _getOrdersByStatus(status);

    if (orders.isEmpty) {
      return _buildEmptyState(status);
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(orders[index]);
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.serviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        order.providerName,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${order.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  order.scheduledDate,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  order.scheduledTime,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            if (order.address.isNotEmpty) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.address,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 16),
            _buildOrderActions(order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
      case 'in progress':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        break;
      case 'completed':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'cancelled':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildOrderActions(Order order) {
    switch (order.status.toLowerCase()) {
      case 'active':
      case 'in progress':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showCancelDialog(order),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red[600],
                  side: BorderSide(color: Colors.red[300]!),
                ),
                child: Text('Cancel'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _contactProvider(order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
                child: Text('Contact'),
              ),
            ),
          ],
        );
      case 'completed':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _reorderService(order),
                child: Text('Reorder'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _rateService(order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                ),
                child: Text('Rate Service'),
              ),
            ),
          ],
        );
      case 'cancelled':
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _reorderService(order),
            child: Text('Reorder'),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildEmptyState(String status) {
    String message;
    IconData icon;

    switch (status) {
      case 'active':
        message = 'No active orders';
        icon = Icons.pending_actions;
        break;
      case 'completed':
        message = 'No completed orders yet';
        icon = Icons.check_circle_outline;
        break;
      case 'cancelled':
        message = 'No cancelled orders';
        icon = Icons.cancel_outlined;
        break;
      default:
        message = 'No orders found';
        icon = Icons.inbox_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your ${status} orders will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  List<Order> _getOrdersByStatus(String status) {
    // Mock data - replace with actual API call
    List<Order> allOrders = [
      Order(
        id: '12345',
        serviceName: 'House Cleaning',
        providerName: 'CleanPro Services',
        providerImage: '', // Empty since we're not using network images
        amount: 120.00,
        scheduledDate: 'Mar 25, 2024',
        scheduledTime: '10:00 AM',
        address: '123 Main St, City',
        status: 'Active',
      ),
      Order(
        id: '12346',
        serviceName: 'Plumbing Repair',
        providerName: 'Quick Fix Plumbing',
        providerImage: '', // Empty since we're not using network images
        amount: 85.00,
        scheduledDate: 'Mar 20, 2024',
        scheduledTime: '2:00 PM',
        address: '456 Oak Ave, City',
        status: 'Completed',
      ),
      Order(
        id: '12347',
        serviceName: 'Garden Maintenance',
        providerName: 'Green Thumb Landscaping',
        providerImage: '', // Empty since we're not using network images
        amount: 95.00,
        scheduledDate: 'Mar 18, 2024',
        scheduledTime: '9:00 AM',
        address: '789 Pine Rd, City',
        status: 'Cancelled',
      ),
    ];

    return allOrders.where((order) =>
    order.status.toLowerCase() == status.toLowerCase()).toList();
  }

  void _showCancelDialog(Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: Text('Are you sure you want to cancel this order?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelOrder(order);
              },
              child: Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _cancelOrder(Order order) {
    // Implement cancel order logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order cancelled successfully')),
    );
  }

  void _contactProvider(Order order) {
    // Implement contact provider logic (call, message, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacting ${order.providerName}...')),
    );
  }

  void _reorderService(Order order) {
    // Navigate to booking page with pre-filled service details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirecting to book ${order.serviceName}...')),
    );
  }

  void _rateService(Order order) {
    // Navigate to rating page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening rating page...')),
    );
  }
}

class Order {
  final String id;
  final String serviceName;
  final String providerName;
  final String providerImage;
  final double amount;
  final String scheduledDate;
  final String scheduledTime;
  final String address;
  final String status;

  Order({
    required this.id,
    required this.serviceName,
    required this.providerName,
    required this.providerImage,
    required this.amount,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.address,
    required this.status,
  });
}