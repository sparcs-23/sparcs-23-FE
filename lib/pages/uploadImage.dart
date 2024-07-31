import 'package:flutter/material.dart';
import 'package:sparcs_fe/pages/activity.dart';
import 'package:sparcs_fe/pages/event.dart';
import '../main.dart';

import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' if (dart.library.html) 'dart:html' as html;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key, required this.eventInfo});
  final Map eventInfo;
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _comment = TextEditingController();
  File? _image; //이미지를 담을 변수 선언
  Uint8List? _webImage; // Image bytes for web

  Future<void> getImage() async {
    // 웹에서 카메라나 갤러리에서 파일을 선택할 수 있게 FilePicker를 사용
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
      // 웹에서 카메라를 직접 열 수 있는 옵션은 없으므로, 갤러리에서 파일을 선택하는 방식으로 구현
      allowCompression: true,
    );
    if (result != null) {
      setState(() {
        if (kIsWeb) {
          _webImage = result.files.first.bytes;
        } else {
          _image = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> _addImage() async {
    if (_webImage == null) {
      print('No image selected');
      return;
    }

    final uri = Uri.parse(
        "https://crystal.kaist.ac.kr/upload-image/${widget.eventInfo['uid']}/${_comment.text}");

    var request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        _webImage!,
        filename: 'upload.png', // You can change the filename
        contentType: MediaType('image', 'png'),
      ),
    );

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      // Add other headers if necessary
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color.fromRGBO(255, 237, 224, 1)),
                child: const Text(
                  '이제 인증해볼까요!',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'PretendardSemiBold',
                    color: Color.fromRGBO(255, 142, 61, 1),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                widget.eventInfo['Title'],
                style: tt(context).displayLarge,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: _image != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image.file(_image!))
                    : _webImage != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Image.memory(_webImage!),
                          )
                        : Image(
                            image: const AssetImage('assets/images/upload.png'),
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "간단한 인증 소감 작성하기",
                  ),
                  controller: _comment,
                  maxLength: 10,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  _addImage();
                  Navigator.of(context).pop();
                },
                child: Image(
                    image: const AssetImage('assets/images/completeButton.png'),
                    width: MediaQuery.of(context).size.width * 0.7),
              )
            ],
          ),
        ),
      ),
    );
  }
}
