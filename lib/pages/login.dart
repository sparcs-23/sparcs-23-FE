import 'package:flutter/material.dart';
import 'package:sparcs_fe/main.dart';
import 'package:sparcs_fe/pages/home.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userName = TextEditingController();

  List<String> starList = <String>[
    '임영웅',
    '송가인',
  ];
  List<String> locationList = <String>[
    '대전/세종',
    '인천',
  ];
  String dropdownValue = '임영웅';
  String locationValue = '대전/세종';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _loginPush() async {
    // if (_locationMessage == '내 위치 찾기') {
    //   showDialog(context: context, builder: )
    // }
    if (_formKey.currentState!.validate() && _locationMessage != '내 위치 찾기') {
      http.Response response = await http.get(
        Uri.parse("https://crystal.kaist.ac.kr/fanevent/$dropdownValue/대전"),
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userName: _userName.text,
                    starName: dropdownValue,
                    activityList: jsonDecode(utf8.decode(response.bodyBytes)),
                  )),
          (Route<dynamic> route) => false);
    }
  }

  String _locationMessage = "내 위치 찾기";
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return early.
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return early.
        setState(() {
          _locationMessage = "위치 접근권한을 허용해주세요!";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return early.
      setState(() {
        _locationMessage =
            "Location permissions are permanently denied, we cannot request permissions.";
      });
      return;
    }

    // When we reach here, permissions are granted and we can get the location.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    http.Response response = await http.get(
      Uri.parse(
          "https://crystal.kaist.ac.kr/geocode/${position.latitude}/${position.longitude}"),
    );
    setState(() {
      _locationMessage = jsonDecode(utf8.decode(response.bodyBytes));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '딱 3가지만 알려주세요!',
              style: TextStyle(
                  fontFamily: 'PretendardBold',
                  fontSize: 18,
                  color: cs(context).primary),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/one.png'),
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      "성함이 어떻게 되시나요?",
                      style: tt(context).displayLarge,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return "성함을 입력해주세요!";
                      return null;
                    },
                    controller: _userName,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/two.png'),
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      "어느 지역에 거주하시나요?",
                      style: tt(context).displayLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(96, 231, 231, 231),
                  ),
                  child: TextButton(
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      child: Text(
                        _locationMessage,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                Image(
                  image: const AssetImage('assets/images/three.png'),
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  "관심있는 아티스트를 선택해주세요!",
                  style: tt(context).displayLarge,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(96, 231, 231, 231)),
              child: DropdownButton<String>(
                padding: const EdgeInsets.fromLTRB(30, 7, 30, 7),
                focusColor: Colors.white,
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: starList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: GestureDetector(
                      child: const Image(
                        image: AssetImage('assets/images/enterbutton.png'),
                      ),
                      onTap: () {
                        _loginPush();
                      },
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
