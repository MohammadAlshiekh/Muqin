import 'package:flutter/material.dart';
import 'package:muqin/Widgets/DrawerWidgets/drawer_header.dart';
import 'package:muqin/Widgets/DrawerWidgets/drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const MyDrawerHeader(), // Function to create the header
          DrawerItem(
            icon: Icons.home,
            text: 'الصفحة الرئيسية',
            onTap: () => Navigator.of(context).pop(),
          ),
          DrawerItem(
            icon: Icons.book,
            text: 'قوائم القراءة الخاصة بي',
            onTap: () => Navigator.of(context).pop(),
          ),
          DrawerItem(
            icon: Icons.notifications,
            text: 'تنبيهاتي',
            onTap: () => Navigator.of(context).pop(),
          ),
          DrawerItem(
            icon: Icons.search,
            text: 'البحث',
            onTap: () => Navigator.of(context).pop(),
          ),
          DrawerItem(
            icon: Icons.help_outline,
            text: 'للمساعدة',
            onTap: () => Navigator.of(context).pop(),
          ),
          const Divider(),
          DrawerItem(
            icon: Icons.help_outline,
            text: 'تصميم البرنامج',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}