import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find();
    return Container(
      width: 300,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            userHeader(),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Signout',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    onTap: () => _authController.signOut(),
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader userHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        'Tesla',
        style: TextStyle(
            color: Colors.amber, fontSize: 23, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text('tesla@gmail.com'),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1593281796622-1de5647e871e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8eWVsbG93JTIwbW91bnRhaW58ZW58MHx8MHx8&w=1000&q=80'),
              fit: BoxFit.cover)),
    );
  }
}
