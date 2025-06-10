import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Location Selector',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color(0xFFE53E3E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFE53E3E),
          brightness: Brightness.light,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE53E3E),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: DeliveryInfoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Store {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? address;

  Store({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: int.parse(json['id'].toString()),
      name: json['name'] as String,
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      address: json['address'] as String?,
    );
  }
}

class StoreDistance {
  final Store store;
  final double distance;

  StoreDistance({required this.store, required this.distance});
}

class DeliveryInfo {
  final int orderId;
  final String receiverName;
  final String receiverPhone;
  final String deliveryAddress;
  final int storeId;
  final String shippingNotes;

  DeliveryInfo({
    required this.orderId,
    required this.receiverName,
    required this.receiverPhone,
    required this.deliveryAddress,
    required this.storeId,
    required this.shippingNotes,
  });
}

// Màn hình 1: Nhập thông tin giao hàng
class DeliveryInfoScreen extends StatefulWidget {
  @override
  _DeliveryInfoScreenState createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  LatLng? _selectedLocation;
  String _selectedAddress = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Lấy vị trí hiện tại
  Future<void> _getCurrentLocation() async {
    try {
      setState(() => _isLoading = true);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showMessage('Vui lòng bật dịch vụ định vị');
        setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'Quyền vị trí bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt.',
        );
        setState(() => _isLoading = false);
        return;
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _selectedLocation = LatLng(position.latitude, position.longitude);
        });
        _mapController.move(_selectedLocation!, 15.0);
        await _getAddressFromCoordinates(_selectedLocation!);
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      _showMessage('Lỗi khi lấy vị trí: $e');
    }
  }

  // Lấy địa chỉ từ tọa độ
  Future<void> _getAddressFromCoordinates(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress =
              '${place.street ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.administrativeArea ?? ''}';
          _addressController.text = _selectedAddress;
        });
      }
    } catch (e) {
      _showMessage('Lỗi khi lấy địa chỉ: $e');
    }
  }

  // Xác nhận thông tin và chuyển sang màn hình chọn cửa hàng
  void _confirmDeliveryInfo() {
    if (_selectedLocation == null) {
      _showMessage('Vui lòng chọn địa điểm giao hàng');
      return;
    }

    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      _showMessage('Vui lòng nhập đầy đủ thông tin bắt buộc');
      return;
    }

    DeliveryInfo deliveryInfo = DeliveryInfo(
      orderId: 1, // Đặt giá trị mặc định là 1
      receiverName: _nameController.text,
      receiverPhone: _phoneController.text,
      deliveryAddress: _addressController.text,
      storeId: 0, // Sẽ được cập nhật từ cửa hàng gần nhất
      shippingNotes: _notesController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoreSelectionScreen(deliveryInfo: deliveryInfo),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFFE53E3E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Thông tin giao hàng',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFE53E3E),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Container
          Container(
            height: 280,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(10.8231, 106.6297),
                      initialZoom: 13.0,
                      onTap: (tapPosition, point) async {
                        setState(() {
                          _selectedLocation = point;
                        });
                        await _getAddressFromCoordinates(point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.delivery_app',
                      ),
                      MarkerLayer(
                        markers: [
                          if (_selectedLocation != null)
                            Marker(
                              width: 50.0,
                              height: 50.0,
                              point: _selectedLocation!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE53E3E),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_isLoading)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFE53E3E),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Form thông tin
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedLocation != null) ...[
                    Card(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE53E3E).withOpacity(0.1),
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFFE53E3E),
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Địa điểm giao hàng',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE53E3E),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              _selectedAddress.isNotEmpty
                                  ? _selectedAddress
                                  : 'Đang tải địa chỉ...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tọa độ: ${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],

                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFFE53E3E),
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Thông tin người nhận',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE53E3E),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          _buildTextField(
                            controller: _nameController,
                            label: 'Tên người nhận *',
                            icon: Icons.person_outline,
                          ),
                          SizedBox(height: 16),

                          _buildTextField(
                            controller: _phoneController,
                            label: 'Số điện thoại *',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 16),

                          _buildTextField(
                            controller: _addressController,
                            label: 'Địa chỉ chi tiết',
                            icon: Icons.location_on_outlined,
                            maxLines: 2,
                          ),
                          SizedBox(height: 16),

                          _buildTextField(
                            controller: _notesController,
                            label: 'Ghi chú giao hàng',
                            icon: Icons.note_outlined,
                            maxLines: 3,
                          ),
                          SizedBox(height: 24),

                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE53E3E).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _confirmDeliveryInfo,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Xác nhận thông tin giao hàng',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFE53E3E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE53E3E), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        labelStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

// Màn hình 2: Chọn cửa hàng gần nhất
class StoreSelectionScreen extends StatefulWidget {
  final DeliveryInfo deliveryInfo;

  StoreSelectionScreen({required this.deliveryInfo});

  @override
  _StoreSelectionScreenState createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> {
  // API Configuration
  static const String LARAVEL_API_BASE = 'http://10.0.2.2:8000';
  static const String OPENROUTE_API_KEY =
      '5b3ce3597851110001cf6248a2cdfe8c4fba46ca9ebc494415d402e5';

  List<Store> _stores = [];
  StoreDistance? _nearestStore;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStoresAndFindNearest();
  }

  // Lấy danh sách cửa hàng và tìm cửa hàng gần nhất
  Future<void> _loadStoresAndFindNearest() async {
    setState(() => _isLoading = true);

    try {
      await _loadStores();
      await _findNearestStore();
    } catch (e) {
      _showMessage('Lỗi khi tải dữ liệu: $e');
    }

    setState(() => _isLoading = false);
  }

  // Lấy danh sách cửa hàng từ API
  Future<void> _loadStores() async {
    try {
      final response = await http.get(
        Uri.parse('$LARAVEL_API_BASE/stores'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          _stores = data.map((json) => Store.fromJson(json)).toList();
        } else if (data['data'] != null) {
          List<dynamic> storesJson = data['data'];
          _stores = storesJson.map((json) => Store.fromJson(json)).toList();
        } else {
          _showMessage('Dữ liệu cửa hàng không hợp lệ từ API');
        }
      } else {
        _showMessage('Lỗi khi tải danh sách cửa hàng: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage('Lỗi kết nối khi tải cửa hàng: $e');
    }
  }

  // Tìm cửa hàng gần nhất
  Future<void> _findNearestStore() async {
    if (_stores.isEmpty) return;

    StoreDistance? nearest;
    double minDistance = double.infinity;

    for (Store store in _stores) {
      double distance = await _calculateDistance(
        LatLng(10.8231, 106.6297), // Default to Ho Chi Minh City
        LatLng(store.latitude, store.longitude),
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = StoreDistance(store: store, distance: distance);
      }
    }

    setState(() {
      _nearestStore = nearest;
    });
  }

  // Tính khoảng cách sử dụng OpenRouteService
  Future<double> _calculateDistance(LatLng from, LatLng to) async {
    try {
      final url = 'https://api.openrouteservice.org/v2/directions/driving-car';
      final coordinates = [
        [from.longitude, from.latitude],
        [to.longitude, to.latitude],
      ];

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': OPENROUTE_API_KEY,
          'Content-Type': 'application/json',
        },
        body: json.encode({'coordinates': coordinates}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['routes'][0]['summary']['distance'] / 1000.0; // km
      }
    } catch (e) {
      print('Lỗi khi tính khoảng cách: $e');
    }

    // Fallback: tính khoảng cách trực tiếp
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        ) /
        1000.0;
  }

  // Gửi thông tin đặt hàng
  Future<void> _submitOrder() async {
    if (_nearestStore == null) {
      _showMessage('Không tìm thấy cửa hàng gần nhất');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$LARAVEL_API_BASE/deliveries'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'order_id': widget.deliveryInfo.orderId,
          'receiver_name': widget.deliveryInfo.receiverName,
          'receiver_phone': widget.deliveryInfo.receiverPhone,
          'delivery_address': widget.deliveryInfo.deliveryAddress,
          'store_id': _nearestStore!.store.id, // Lấy từ cửa hàng gần nhất
          'shipping_notes': widget.deliveryInfo.shippingNotes,
        }),
      );

      if (response.statusCode == 201) {
        _showSuccessDialog();
      } else {
        _showMessage('Lỗi khi đặt hàng: ${response.statusCode}');
      }
    } catch (e) {
      _showMessage('Lỗi kết nối: $e');
    }

    setState(() => _isLoading = false);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 32),
              SizedBox(width: 12),
              Text(
                'Đặt hàng thành công!',
                style: TextStyle(
                  color: Color(0xFFE53E3E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Đơn hàng của bạn đã được gửi thành công đến ${_nearestStore!.store.name}.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Hoàn tất',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFFE53E3E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Cửa hàng giao hàng',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFE53E3E),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          _isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFE53E3E),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Đang tìm cửa hàng gần nhất...',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // Thông tin giao hàng
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE53E3E).withOpacity(0.1),
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Color(0xFFE53E3E),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Thông tin giao hàng',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE53E3E),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              _buildInfoRow(
                                Icons.person,
                                'Người nhận',
                                widget.deliveryInfo.receiverName,
                              ),
                              _buildInfoRow(
                                Icons.phone,
                                'SĐT',
                                widget.deliveryInfo.receiverPhone,
                              ),
                              _buildInfoRow(
                                Icons.location_on,
                                'Địa chỉ',
                                widget.deliveryInfo.deliveryAddress,
                              ),
                              if (widget.deliveryInfo.shippingNotes.isNotEmpty)
                                _buildInfoRow(
                                  Icons.note,
                                  'Ghi chú',
                                  widget.deliveryInfo.shippingNotes,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Cửa hàng gần nhất
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cửa hàng gần nhất',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE53E3E),
                            ),
                          ),
                          SizedBox(height: 16),
                          _nearestStore == null
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.store_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Không tìm thấy cửa hàng nào',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(0xFFE53E3E).withOpacity(0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE53E3E),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(
                                                    0xFFE53E3E,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.store,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    'GẦN NHẤT',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  _nearestStore!.store.name,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFE53E3E),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[200]!,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            _buildStoreDetailRow(
                                              Icons.location_on,
                                              'Địa chỉ',
                                              _nearestStore!.store.address ??
                                                  'Chưa có địa chỉ',
                                            ),
                                            Divider(color: Colors.grey[200]),
                                            _buildStoreDetailRow(
                                              Icons.route,
                                              'Khoảng cách',
                                              '${_nearestStore!.distance.toStringAsFixed(2)} km',
                                            ),
                                            Divider(color: Colors.grey[200]),
                                            _buildStoreDetailRow(
                                              Icons.access_time,
                                              'Thời gian giao hàng ước tính',
                                              '${(_nearestStore!.distance * 5).round()}-${(_nearestStore!.distance * 8).round()} phút',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),

                    // Order button with padding
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFE53E3E).withOpacity(0.4),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Xác nhận đặt hàng',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Color(0xFFE53E3E)),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE53E3E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Color(0xFFE53E3E)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
