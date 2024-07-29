import 'package:flutter/material.dart';
import '../main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List dummyActivity = [
    {
      'name': '임영웅 월평역 생일카페 인증',
      'D-Day': '20240815',
      'attendee': '120',
      'content':
          '임영웅의 30번째 생일을 기념하여 팬들이 마련한 생일카페! 임영웅의 다양한 사진과 활동을 기념하는 장식들을 보며 함께 축하하고, 기쁨을 나누는 시간을 보내요!'
    },
  ];

  late String newsSummary = '';
  Future getNews() async {
    // await http
    //     .get(
    //   Uri.parse(
    //       "http://deepurban.kaist.ac.kr:5000/news-summary-aegyo/%EC%9E%84%EC%98%81%EC%9B%85/%EC%98%A5%EC%9E%90%EB%88%84%EB%82%98"),
    // )
    //     .then((value) {
    //   setState(() {
    //     newsSummary = jsonDecode(utf8.decode(value.bodyBytes));
    //   });
    // });
    http.Response response = await http.get(
      Uri.parse(
          "http://deepurban.kaist.ac.kr:5000/news-summary-aegyo/%EC%9E%84%EC%98%81%EC%9B%85/%EC%98%A5%EC%9E%90%EB%88%84%EB%82%98"),
    );
    return jsonDecode(utf8.decode(response.bodyBytes))['result'];
  }

  void getNews2() async {
    http.Response response = await http.get(
      Uri.parse(
          "http://deepurban.kaist.ac.kr:5000/news-summary-aegyo/%EC%9E%84%EC%98%81%EC%9B%85/%EC%98%A5%EC%9E%90%EB%88%84%EB%82%98"),
    );
    setState(() {
      newsSummary = jsonDecode(utf8.decode(response.bodyBytes))['result'];
    });
    print(newsSummary);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getNews2();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubjectText(content: '오늘의 임영웅 뉴스 '),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 224, 224, 224)),
            child: SingleChildScrollView(
                child: FutureBuilder(
                    future: getNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}');
                      }
                    })
                //Text(newsSummary)
                ),
          ),
          const SubjectText(content: '내가 참여할 활동'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: dummyActivity.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dummyActivity[index]['name']),
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
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            '인증하러 가기',
                                            style: TextStyle(
                                                color: cs(context).primary),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          '${DateTime.parse(dummyActivity[index]['D-Day']).difference(DateTime.now()).inDays}일 남음'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Icon(Icons.cake),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
          const SubjectText(content: '인기 많은 활동')
        ],
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
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
