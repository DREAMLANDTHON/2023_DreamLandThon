import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'loadmapdetail.dart';

var apiKey = dotenv.env['apiKey'];
var apiUrl = dotenv.env['apiUrl'];

class loadMapList extends StatelessWidget {
  final String result;
  final String prompt1;

  loadMapList(this.result, this.prompt1);

  Widget buildButton(
      IconData iconData, Color iconColor, double left, double top) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 30.0,
        ),
      ),
    );
  }

  Widget buildButton2(
    String text,
    double left,
    double top,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top),
      child: Row(
        // Row로 아이콘과 텍스트를 옆으로 나란히 배치
        children: [
          Container(),
          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격 조정
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Split the GPT-3 response into lines
    List<String> lines =
        result.split('\n').where((line) => line.trim().isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PERPL',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFBB85FF),
            fontFamily: "PottaOneRegular",
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              '미래 개발자 이오드님을 위한 DREAM MAP',
              style: TextStyle(
                fontSize: 15.0, // 원하는 폰트 크기로 설정
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0), // 위젯간 간격 조정을 위한 SizedBox 추가

            Align(
              alignment: Alignment.centerLeft,
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: 18.0, // The width of the circular border
                    height: 500.0, // The height of the circular border
                    decoration: BoxDecoration(
                      color: Color(0xFFBB85FF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < lines.length; i++)
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 50.0), // 아이콘과 텍스트 사이 간격
                                Text(
                                  lines[i], // 해당 텍스트를 가져옴
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: buildButton(
                                  Icons.circle, Colors.white, 10, 0),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: buildButton(
                                Icons.arrow_circle_down,
                                Colors.grey,
                                10,
                                0,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ]),
            ),
          ])),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              // 저장 아이콘
              Icons.save_alt,
              size: 25,
            ),
            // 캘린더
            Icon(
              Icons.calendar_month_rounded,
              size: 25,
            ),
            // 홈
            Icon(
              Icons.home,
              size: 25,
            ),
            // 후기
            Icon(
              Icons.note_add_rounded,
              size: 25,
            ),
            // 마이페이지
            Icon(
              Icons.person,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> generateText2(String prompt, String prompt1) async {
  String prom = "";
  if (prompt.contains("자격증")) {
    prom = "$prompt1 직종 관련 한국 자격증을 알려줘.";
  } else {
    prom = "$prompt 를 하려는데 알려줘. 근데 오타없이 키워드만 간단히.";
  }
  final response = await http.post(
    Uri.parse(apiUrl!),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': prom,
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );
  developer.log('log me', name: 'my.app.category');

  developer.log('$prompt', name: 'my.app.category');

  Map<String, dynamic> newresponse =
      jsonDecode(utf8.decode(response.bodyBytes));

  return newresponse['choices'][0]['text'];
}

Future<String> generateText3(String prompt) async {
  final response = await http.post(
    Uri.parse(apiUrl!),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': "$prompt 를 하려는데 추천 책과 강의 영상을 알려줘! 근데 오타 없이 키워드만 간단히.",
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> newresponse =
      jsonDecode(utf8.decode(response.bodyBytes));

  return newresponse['choices'][0]['text'];
}


/*

            */

            /*

                      Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬 추가
              children: [
                buildButton2(4, () {}, false, context),
                buildButton2(5, () {}, false, context),
                buildButton2(6, () {}, false, context),
              ],
            ),
          ),
            Widget buildButton2(
    int text,
    Function() onPressed,
    bool isPurple,
    BuildContext context,
  ) {
    return Container(
      width: 15, // 버튼의 가로 크기를 지정
      height: 70, // 버튼의 세로 크기를 지정
      padding:
          EdgeInsets.only(left: .0), // 버튼 왼쪽에 여백을 줍니다. 여기서 20.0은 원하는 여백 크기입니다.
      child: InkWell(
        onTap: () async {
          List<String> lines = result
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList();
          String prom = lines[text];
          String result2 = await generateText2(prom, prompt1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LineDetailPage(result2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(2.0),
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFFBB85FF),
          ),
          child: Center(
            // 아이콘을 버튼 내에 가운데 정렬하기 위해 Center 위젯 사용
            child: Icon(
              isPurple
                  ? Icons.check_circle_outline // true면 동그라미 아이콘
                  : Icons.circle_outlined // false면 X 아이콘
              ,
              color: isPurple
                  ? Color.fromARGB(255, 0, 255, 8)
                  : Colors.grey, // 아이콘의 색상을 설정합니다.
              size: 24.0, // 아이콘의 크기를 설정합니다.
            ),
          ),
        ),
      ),
    );
  }

            */