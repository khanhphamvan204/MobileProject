import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/pages/account/account_page.dart';
import 'package:food_ordering/pages/auth/sign_in_page.dart';
import 'package:food_ordering/pages/auth/sign_up_page.dart';
import 'package:food_ordering/pages/cart/cart_history.dart';
import 'package:food_ordering/pages/cart/cart_page.dart';
import 'package:food_ordering/pages/home/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // List of pages
  final List<Widget> _pages = [
    const MainFoodPage(),
    SignInPage(),
    // const CartPage(),
    // const Center(
    //   child: Text("Đơn hàng đã mua", style: TextStyle(fontSize: 20)),
    // ),
    const CartHistory(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for icon scaling
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Trigger animation on tap
    _animationController.forward().then((_) => _animationController.reverse());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTapNav,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.grey[400],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          items: [
            _buildNavBarItem(CupertinoIcons.home, "Trang chủ", 0),
            _buildNavBarItem(CupertinoIcons.cart, "Giỏ hàng", 1),
            _buildNavBarItem(CupertinoIcons.archivebox_fill, "Đơn hàng", 2),
            _buildNavBarItem(CupertinoIcons.person, "Tài khoản", 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _selectedIndex == index ? _animation.value : 1.0,
            child: Icon(
              icon,
              size: 28,
              color:
                  _selectedIndex == index
                      ? AppColors.mainColor
                      : Colors.grey[400],
            ),
          );
        },
      ),
      label: label,
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_ordering/Utility/color.dart'; // Giả sử bạn có file này
// import 'package:food_ordering/pages/cart/cart_history.dart';
// import 'package:food_ordering/pages/cart/cart_page.dart';
// import 'package:food_ordering/pages/home/main_food_page.dart';

// // Giả định AppColors được định nghĩa như sau nếu bạn chưa có
// // class AppColors {
// //   static const Color mainColor = Colors.blue; // Thay thế bằng màu chính của bạn
// // }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex =
//       2; // Đặt MainFoodPage (nay là Pizza) làm mục được chọn mặc định
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   // Sắp xếp lại danh sách các trang để MainFoodPage tương ứng với vị trí mới (index 2)
//   final List<Widget> _pages = [
//     const CartPage(), // Index 0
//     const CartHistory(), // Index 1
//     const MainFoodPage(), // Index 2 (Trước đây là Home, nay sẽ là Pizza)
//     const Center(
//       child: Text("Profile Page", style: TextStyle(fontSize: 20)),
//     ), // Index 3
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize animation controller for icon scaling
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   void _onTapNav(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // Trigger animation on tap
//     _animationController.forward().then((_) => _animationController.reverse());
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               spreadRadius: 2,
//               offset: const Offset(0, -2),
//             ),
//           ],
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: _onTapNav,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           selectedItemColor: AppColors.mainColor,
//           unselectedItemColor: Colors.grey[400],
//           showSelectedLabels: true,
//           showUnselectedLabels: true,
//           selectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 12,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 12,
//           ),
//           items: [
//             // Sắp xếp lại các mục và thay đổi icon cho "Home"
//             _buildNavBarItem(CupertinoIcons.cart, "Cart", 0),
//             _buildNavBarItem(CupertinoIcons.archivebox_fill, "History", 1),
//             // Icon Pizza cho MainFoodPage, giữ label "Home" hoặc đổi thành "Thực đơn" nếu muốn
//             _buildNavBarItem(FontAwesomeIcons.pizzaSlice, "Home", 2),
//             _buildNavBarItem(CupertinoIcons.person, "Profile", 3),
//           ],
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem _buildNavBarItem(
//     IconData icon,
//     String label,
//     int index,
//   ) {
//     return BottomNavigationBarItem(
//       icon: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _selectedIndex == index ? _animation.value : 1.0,
//             child: Icon(
//               icon,
//               size: 28,
//               color:
//                   _selectedIndex == index
//                       ? AppColors.mainColor
//                       : Colors.grey[400],
//             ),
//           );
//         },
//       ),
//       label: label,
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Đảm bảo đã thêm vào pubspec.yaml
// // import 'package:food_ordering/Utility/color.dart'; // File màu của bạn
// import 'package:food_ordering/pages/cart/cart_history.dart';
// import 'package:food_ordering/pages/cart/cart_page.dart';
// import 'package:food_ordering/pages/home/main_food_page.dart';

// // Giả định AppColors được định nghĩa như sau nếu bạn chưa có
// class AppColors {
//   static const Color mainColor =
//       Colors.deepOrangeAccent; // Thay thế bằng màu chính của bạn
//   // static const Color secondaryText = Colors.grey;
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // _selectedIndex = 2 ban đầu là đúng, MainFoodPage (Pizza) sẽ là trang mặc định.
//   int _selectedIndex = 2;

//   // Danh sách các trang từ code của bạn
//   final List<Widget> _pages = [
//     const CartPage(), // Index 0
//     const CartHistory(), // Index 1
//     const MainFoodPage(), // Index 2 (Pizza/Thực đơn - sẽ là FAB)
//     const Center(
//       // Index 3
//       child: Text("Profile Page", style: TextStyle(fontSize: 20)),
//     ),
//   ];

//   // Animation controller không còn cần thiết trực tiếp cho BottomAppBar theo cách này
//   // Bạn có thể thêm animation tùy chỉnh cho các mục nếu muốn sau
//   // late AnimationController _animationController;
//   // late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     // _animationController = AnimationController(...);
//     // _animation = Tween<double>(...).animate(...);
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // _animationController.forward().then((_) => _animationController.reverse()); // Không dùng nữa
//   }

//   @override
//   void dispose() {
//     // _animationController.dispose(); // Không dùng nữa
//     super.dispose();
//   }

//   // Helper widget để tạo các mục trên BottomAppBar
//   Widget _buildBottomAppBarItem({
//     required IconData icon,
//     required String label,
//     required int pageIndexToActivate, // Index của trang trong _pages
//   }) {
//     final bool isSelected = _selectedIndex == pageIndexToActivate;
//     final Color activeColor = AppColors.mainColor;
//     final Color inactiveColor = Colors.grey[600]!;

//     return Expanded(
//       child: InkWell(
//         onTap: () => _onItemTapped(pageIndexToActivate),
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 6.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 icon,
//                 color: isSelected ? activeColor : inactiveColor,
//                 size: 24,
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: isSelected ? activeColor : inactiveColor,
//                   fontSize: 10,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Xác định màu cho icon và text của FAB dựa trên _selectedIndex
//     // MainFoodPage là index 2
//     final bool isFabSelected = _selectedIndex == 2;
//     final Color fabIconColor =
//         isFabSelected ? AppColors.mainColor : Colors.black87;
//     final Color fabTextColor =
//         isFabSelected ? AppColors.mainColor : Colors.black54;
//     final FontWeight fabFontWeight =
//         isFabSelected ? FontWeight.bold : FontWeight.normal;

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _onItemTapped(2), // MainFoodPage là index 2
//         backgroundColor: Colors.white,
//         elevation: 6.0,
//         shape: const CircleBorder(),
//         child: SizedBox(
//           width: 56,
//           height: 56,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FaIcon(
//                 // Sử dụng FontAwesomeIcons
//                 FontAwesomeIcons.pizzaSlice,
//                 size: 24, // Điều chỉnh kích thước nếu cần
//                 color: fabIconColor,
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 "Thực đơn", // Label cho FAB như trong hình
//                 style: TextStyle(
//                   fontSize: 9,
//                   color: fabTextColor,
//                   fontWeight: fabFontWeight,
//                 ),
//                 maxLines: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         color: Colors.white, // Màu nền của BottomAppBar
//         elevation: 10.0, // Shadow (tương tự boxShadow trong Container cũ)

//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             children: <Widget>[
//               // Mục cho CartPage (index 0)
//               _buildBottomAppBarItem(
//                 icon: CupertinoIcons.cart,
//                 label: "Cart", // Giữ label "Cart"
//                 pageIndexToActivate: 0,
//               ),
//               // Mục cho CartHistory (index 1)
//               _buildBottomAppBarItem(
//                 icon: CupertinoIcons.archivebox_fill,
//                 label: "History", // Giữ label "History"
//                 pageIndexToActivate: 1,
//               ),
//               const Spacer(), // Tạo khoảng trống cho FAB ở giữa
//               // Mục cho ProfilePage (index 3)
//               _buildBottomAppBarItem(
//                 icon: CupertinoIcons.person,
//                 label: "Profile", // Giữ label "Profile"
//                 pageIndexToActivate: 3,
//               ),

//               const Expanded(child: SizedBox()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
