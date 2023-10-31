import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavigationBar(
      {required this.selectedIndex, required this.onItemTapped});

  Widget _buildIcon(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color.fromRGBO(67, 176, 255, 1) : const Color.fromARGB(255, 114, 114, 114), // Mengganti warna ikon saat dipilih
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(67, 176, 255, 1),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home_rounded, 'Home', selectedIndex == 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.chat_rounded, 'TechTalk AI', selectedIndex == 1),
          label: 'Chat AI',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.bookmark_rounded, 'Bookmark', selectedIndex == 2),
          label: 'Bookmark',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.person_rounded, 'Profile', selectedIndex == 3),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromRGBO(67, 176, 255, 1),
      unselectedItemColor: const Color.fromRGBO(67, 176, 255, 1),
      elevation: 1,
    );
  }
}