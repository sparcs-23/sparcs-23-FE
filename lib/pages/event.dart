import 'package:flutter/material.dart';
import 'package:sparcs_fe/main.dart';
import 'package:sparcs_fe/pages/participate.dart';
import 'landing.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.eventInfo});
  final Map eventInfo;
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  void _getImages() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://crystal.kaist.ac.kr/event-checkins/${widget.eventInfo['uid']}"),
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ParticiPage(eventInfo: widget.eventInfo, imageList:jsonDecode(utf8.decode(response.bodyBytes))  );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: const ColorFilter.mode(
                      Color.fromARGB(133, 0, 0, 0), BlendMode.darken),
                  image: NetworkImage(
                      "https://crystal.kaist.ac.kr${widget.eventInfo['imgurl']}"),
                  fit: BoxFit.cover),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DayRemainWidget(content: widget.eventInfo['DaysRemaining']),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    widget.eventInfo['Title'],
                    style: tt(context).headlineLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    widget.eventInfo['ParticipantCount'],
                    style: tt(context).headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/left.png'),
                          width: 20,
                        ),
                        Image(
                          image: AssetImage('assets/images/right.png'),
                          width: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.eventInfo['Description'],
                              textAlign: TextAlign.center,
                              style: tt(context).bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                  child: Text(
                    '상세정보',
                    style: tt(context).displayLarge,
                  ),
                ),
                Column(
                  children: [
                    EventInfo(
                      title: '일시:',
                      content: widget.eventInfo['Date'],
                    ),
                    EventInfo(
                      title: '위치:',
                      content: widget.eventInfo['Location'],
                    ),
                    EventInfo(
                      title: '기타:',
                      content: widget.eventInfo['AdditionalInfo'],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _getImages();
                },
                child: Image(
                    image: const AssetImage('assets/images/participate.png'),
                    width: MediaQuery.of(context).size.width * 0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventInfo extends StatelessWidget {
  const EventInfo({
    super.key,
    required this.content,
    required this.title,
  });

  final String content;

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: tt(context).bodyMedium,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Text(content, style: tt(context).bodyMedium),
      ],
    );
  }
}
