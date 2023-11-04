import 'package:flutter/material.dart';
import 'package:walking_app/ViewModel/top_screen_view_model.dart';
import 'package:walking_app/presentation/screens/top_screen.dart';

import 'group_list_screen.dart';
import 'menu_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State with SingleTickerProviderStateMixin {
  late PageController _pageController;

  int _screen = 1;

  // ページ下部に並べるナビゲーションメニューの一覧
  final myBottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.workspaces_filled), label: 'Group'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Menu',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _screen,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          _screen = index;
        }),
        children: [const GroupListScreen(),TopScreen(TopScreenViewModel()), const MenuScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screen,
        onTap: (index) {
          setState(() {
            _screen = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          });
        },
        items: myBottomNavBarItems,
      ),
    );
  }
}
