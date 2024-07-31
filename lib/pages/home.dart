import 'package:flutter/material.dart';
import 'package:sparcs_fe/pages/ranking.dart';
import 'activity.dart';
import 'landing.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.userName,
      required this.starName,
      required this.activityList});
  final String userName;
  final String starName;
  final List activityList;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: const AssetImage('assets/images/textLogo.png'),
          width: MediaQuery.of(context).size.width * 0.2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: [
          LandingPage(
              userName: widget.userName,
              starName: widget.starName,
              activityList: widget.activityList),
          ActivityPage(activityList: widget.activityList),
          const ProfilePage(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.run_circle_outlined), label: '활동'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_outline_rounded), label: '랭킹'),
          ]),
    );
  }
}
