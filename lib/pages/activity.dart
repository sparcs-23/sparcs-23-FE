import 'package:flutter/material.dart';
import '../main.dart';
import 'event.dart';
import 'landing.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.activityList});
  final List activityList;
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<String> list = <String>['대전/세종', '서울', '경기', '인천'];
  String dropdownValue = '대전/세종';

  void readPost(eventInfo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EventPage(eventInfo: eventInfo);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SingleChildScrollView(
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
                  child: Text(
                    value,
                    style: tt(context).displayLarge,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: widget.activityList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: GestureDetector(
                          onTap: () {
                            readPost(widget.activityList[index]);
                          },
                          child: ActivityWidget(widget: widget, index: index),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final ActivityPage widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: const ColorFilter.mode(
                Color.fromARGB(133, 0, 0, 0), BlendMode.darken),
            image: NetworkImage(
                "https://crystal.kaist.ac.kr${widget.activityList[index]['imgurl']}"),
            fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color.fromRGBO(255, 237, 224, 1)),
                child: DayRemainWidget(
                    content: widget.activityList[index]['DaysRemaining']),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            widget.activityList[index]['Title'],
            style: tt(context).headlineLarge,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.activityList[index]['ParticipantCount']}',
                style: tt(context).headlineSmall,
              ),
              Text(
                '상세보기 >',
                style: tt(context).labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
