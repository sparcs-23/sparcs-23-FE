import 'package:flutter/material.dart';
import 'landing.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
  ];

  List<String> list = <String>['대전/세종', '서울', '경기', '인천'];
  String dropdownValue = '대전/세종';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            focusColor: Colors.white,
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
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Container(
                        height: 50,
                        color: Colors.amber,
                        child: SingleChildScrollView(
                            child:
                                Center(child: Text('Entry ${entries[index]}'))),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
