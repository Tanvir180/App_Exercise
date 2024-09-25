import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/screens/bookmark.dart';
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
    return Drawer(

            child: ListView(
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
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  MaterialPageRoute(
                    builder: (context) => const MovieScreen(),
                  );

                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to Profile
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("BookMark"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BookMarkList()
                    ,));
                  // Navigate to Settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.search_off_outlined),
                title: const Text("Search"),
                onTap: (){
                  // print("pressed");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()
                    ,));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
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
