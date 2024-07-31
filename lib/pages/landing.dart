import 'package:flutter/material.dart';
import '../main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'activity.dart';
import 'event.dart';
import 'package:intl/intl.dart';

//import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';

class LandingPage extends StatefulWidget {
  const LandingPage(
      {super.key,
      required this.userName,
      required this.starName,
      required this.activityList});
  final String userName;
  final String starName;
  final List activityList;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late String newsSummary = '';
  Future getNews() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://crystal.kaist.ac.kr/news-summary-aegyo/${widget.starName}/${widget.userName}"),
    );
    setState(() {
      newsSummary = jsonDecode(utf8.decode(response.bodyBytes))['result'];
    });
    return jsonDecode(utf8.decode(response.bodyBytes))['result'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final player = AudioPlayer();
  List iconList = ['Cake.png', 'Picture.png'];

  Future<void> playVoice(url) async {
    await player.play(UrlSource(url));
    setState(() => _playerState = PlayerState.playing);
  }

  void voiceListen() async {
    if (widget.starName == '임영웅') {
      http.Response response = await http.post(
        Uri.parse("https://crystal.kaist.ac.kr/herovoice"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "text": newsSummary,
        }),
      );
      playVoice(
          'https://crystal.kaist.ac.kr${jsonDecode(utf8.decode(response.bodyBytes))['url']}');
    } else {
      http.Response response = await http.post(
        Uri.parse("https://crystal.kaist.ac.kr/againvoice"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "text": newsSummary,
        }),
      );
      playVoice(
          'https://crystal.kaist.ac.kr${jsonDecode(utf8.decode(response.bodyBytes))['url']}');
    }
  }

  void readPost(eventInfo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EventPage(eventInfo: eventInfo);
    }));
  }

  PlayerState? _playerState;
  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubjectText(content: '오늘의 ${widget.starName} 메시지'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 30, 0),
                                    child: SingleChildScrollView(
                                      child: FutureBuilder(
                                          future: getNews(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return Text('${snapshot.data}');
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 234, 234, 100)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 20, 30, 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                voiceListen();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(4),
                                                    ),
                                                    color:
                                                        cs(context).onPrimary),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 7, 20, 7),
                                                  child: Text(
                                                    '내 가수 음성듣기',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'PretendardBold',
                                                      fontSize: 14,
                                                      color:
                                                          cs(context).primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  DateFormat('yyyy.MM.dd')
                                                      .format(DateTime.now())
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'PretendardSemiBold',
                                                      color: Color.fromRGBO(
                                                          75, 75, 75, 0.612)),
                                                ),
                                                Text('From ${widget.starName}',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'PretendardSemiBold',
                                                        color: Color.fromRGBO(
                                                            75,
                                                            75,
                                                            75,
                                                            0.612))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ).then((val) {
                        if (_isPlaying) {
                          setState(() => _playerState = PlayerState.paused);
                          player.dispose();
                        }
                      });
                    },
                    child: Image.asset('assets/images/message.png',
                        width: MediaQuery.of(context).size.width * 0.87,
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SubjectText(content: '내가 참여할 활동'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: GestureDetector(
                          onTap: () {
                            readPost(widget.activityList[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(236, 236, 236, 100),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.activityList[index]['Title'],
                                        style: tt(context).titleLarge,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                color: Color.fromRGBO(
                                                    255, 234, 234, 100)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text('인증하러 가기',
                                                    style: tt(context)
                                                        .labelLarge)),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          Text(
                                            '${widget.activityList[index]['DaysRemaining']}',
                                            style: tt(context).labelMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/${iconList[index]}')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
            const SubjectText(content: '인기 많은 활동'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: GestureDetector(
                          onTap: () {
                            readPost(widget.activityList[index + 4]);
                          },
                          child: ActivityWidget(
                            widget: widget,
                            index: index + 4,
                          ),
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

  final LandingPage widget;
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
              DayRemainWidget(
                  content: '${widget.activityList[index]['DaysRemaining']}'),
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

class DayRemainWidget extends StatelessWidget {
  const DayRemainWidget({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color.fromRGBO(255, 237, 224, 1)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'PretendardSemiBold',
            color: Color.fromRGBO(255, 142, 61, 1),
          ),
        ),
      ),
    );
  }
}

class SubjectText extends StatelessWidget {
  const SubjectText({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Text(
        content,
        style: tt(context).displayLarge,
      ),
    );
  }
}
