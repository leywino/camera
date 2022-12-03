import 'package:flutter/material.dart';
import 'package:gallery/screens/gallery.dart';
import 'package:gallery/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({super.key});

  @override
  State<NavigatorWidget> createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  Color iconUnselectedBackground = const Color.fromARGB(255, 184, 184, 184);
  Color iconSelectedBackground = const Color.fromARGB(255, 18, 111, 179);
  int _currentSelectedIndex = 0;
  final _pages = [
    const ScreenHome(),
    const Gallery(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.poppins(),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: iconUnselectedBackground,
        selectedItemColor: iconSelectedBackground,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
            ),
            label: 'Camera',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
            ),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
