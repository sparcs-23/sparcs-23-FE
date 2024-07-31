import 'package:flutter/material.dart';
import 'package:sparcs_fe/main.dart';
import 'package:sparcs_fe/pages/participate.dart';
import 'landing.dart';
import 'uploadImage.dart';

class ParticiPage extends StatefulWidget {
  const ParticiPage(
      {super.key, required this.eventInfo, required this.imageList});
  final Map eventInfo;
  final List imageList;
  @override
  State<ParticiPage> createState() => _ParticiPageState();
}

class _ParticiPageState extends State<ParticiPage> {
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
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 40),
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
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(widget.imageList.length, (index) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.295,
                        height: MediaQuery.of(context).size.width * 0.295,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(133, 0, 0, 0),
                                  BlendMode.darken),
                              image: NetworkImage(
                                  "https://crystal.kaist.ac.kr${widget.imageList[index]['imgurl']}"),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              widget.imageList[index]['Comment'],
                              style: const TextStyle(
                                  fontFamily: 'PretendardSemiBold',
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UploadPage(
                      eventInfo: widget.eventInfo,
                    );
                  }));
                },
                child: Image(
                    image: const AssetImage('assets/images/uploadButton.png'),
                    width: MediaQuery.of(context).size.width * 0.7),
              )
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
