import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/screens/moviescreen.dart';
import 'package:state_management/Movie_App/screens/searchscreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body:  ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // User Account Header with profile details
              const UserAccountsDrawerHeader(

                accountName: Text("Tanvir Ahammed"),
                accountEmail: Text("tanvir65@gmail.com.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/download.png'), // Replace with your image asset
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),

              // Drawer buttons
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  MaterialPageRoute(
                    builder: (context) => const MovieScreen(),
                  );

                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to Profile
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to Settings
                },
              ),
              ListTile(
                leading: Icon(Icons.search_off_outlined),
                title: Text("Search"),
                onTap: () {
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  // Handle logout
                  Navigator.pop(context);
                },
              ),
            ],

          ),

      );
  }
}
