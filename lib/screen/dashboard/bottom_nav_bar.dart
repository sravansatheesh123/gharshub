import 'package:flutter/material.dart';
import 'package:gharshub/screen/dashboard/dashboard_page.dart';
import 'package:gharshub/screen/dashboard/widget/dashborad_widget.dart';
import 'package:gharshub/screen/profile/profile_page.dart';
import 'package:gharshub/screen/salary_details/salary_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationBarUI extends StatefulWidget {
  const CustomNavigationBarUI({super.key});

  @override
  State<CustomNavigationBarUI> createState() => _CustomNavigationBarUIState();
}

class _CustomNavigationBarUIState extends State<CustomNavigationBarUI> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [DashboardPage(), SalaryDetailsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,
          // backgroundColor: AppColors.bgColor,

          // selectedItemColor: AppColors.blueColor,
          unselectedItemColor: Colors.grey,

          selectedLabelStyle: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              activeIcon: Icon(Icons.payment),
              label: 'Salary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
