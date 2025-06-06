import 'package:flutter/material.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:frontend/pages/home_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DashState();
  }
}

class _DashState extends State<DashBoardPage> {
  final List<Widget> widgetList = [
    HomePage(),
    CartPage(),
    HomePage(),
    HomePage(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: "My Account",
          ),
        ],
      ),
      body: widgetList[index],
    );
  }
}
