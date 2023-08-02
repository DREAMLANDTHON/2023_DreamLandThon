import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'loadmapdetail.dart';
import 'loadmaplist.dart';

var apiKey = dotenv.env['apiKey'];
var apiUrl = dotenv.env['apiUrl'];

// Define the TagWidget class
class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget(this.tag);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey, // Border color here
          width: 0.5, // Border width here
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.0, // Adjust the font size here
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String result;
  final String prompt1;

  ResultPage(this.result, this.prompt1);

  Widget buildButton(
    int text,
    Function() onPressed,
    bool isPurple,
    BuildContext context,
  ) {
    return SizedBox(
      width: 120, // 버튼의 가로 크기를 지정
      height: 30, // 버튼의 세로 크기를 지정
      child: ElevatedButton(
        onPressed: () async {
          List<String> lines = result
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList();
          String prom = lines[text - 1];
          String result2 = await generateText2(prom, prompt1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LineDetailPage(result2),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: isPurple
              ? Color(0xFFBB85FF)
              : const Color.fromARGB(255, 213, 213, 213),
          elevation: 0, // Remove the shadow by setting elevation to 0
          shape: RoundedRectangleBorder(),
        ),
        child: Center(
          // 아이콘을 버튼 내에 가운데 정렬하기 위해 Center 위젯 사용
          child: Icon(
            isPurple
                ? Icons.check_circle_outline // true면 동그라미 아이콘
                : Icons.circle_outlined // false면 X 아이콘
            , // 아이콘 종류를 지정합니다.

            color: isPurple
                ? Color.fromARGB(255, 0, 255, 8)
                : Colors.white, // 아이콘의 색상을 설정합니다.
            size: 24.0, // 아이콘의 크기를 설정합니다.
          ),
        ),
      ),
    );
  }

  Widget buildButton2(
    int text,
    Function() onPressed,
    bool isPurple,
    BuildContext context,
  ) {
    return Container(
      width: 30, // 버튼의 가로 크기를 지정
      height: 140, // 버튼의 세로 크기를 지정
      padding: EdgeInsets.symmetric(horizontal: 0), // 옆 여백을 줄입니다.
      child: InkWell(
        onTap: () async {
          List<String> lines = result
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList();
          String prom = lines[text - 1];
          String result2 = await generateText2(prom, prompt1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LineDetailPage(result2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(7.0),
        child: Ink(
          decoration: BoxDecoration(
            color: isPurple
                ? Color(0xFFBB85FF)
                : const Color.fromARGB(255, 213, 213, 213),
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
                  : Colors.white, // 아이콘의 색상을 설정합니다.
              size: 24.0, // 아이콘의 크기를 설정합니다.
            ),
          ),
        ),
      ),
    );
  }

  void showPopup(BuildContext context, String result) {
    List<String> lines =
        result.split('\n').where((line) => line.trim().isNotEmpty).toList();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Popup Dialog',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: lines.length,
                  itemBuilder: (context, index) {
                    return Text(lines[index]);
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '이오드 님의 DREAM MAP',
              style: TextStyle(
                fontSize: 20.0, // 원하는 폰트 크기로 설정
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0), // 위젯간 간격 조정을 위한 SizedBox 추가
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8.0, // 태그들 간의 간격 조정을 위해 추가
                  children: [
                    TagWidget('#개발자'),
                    TagWidget('#백엔드'),
                    TagWidget('#경력 무'),
                    // 원하는 만큼 추가 태그 위젯을 넣어줄 수 있습니다.
                  ],
                ),
              ),
            ),
            SizedBox(
                height:
                    8.0), // Add spacing between the purple box and the row of TagWidgets
            Row(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // 버튼들이 왼쪽으로 정렬되어 한 줄로 보이도록 설정
                  children: [
                    buildButton(1, () {}, false, context),
                    buildButton(2, () {}, false, context),
                    buildButton(3, () {}, false, context),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                    mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬 추가
                    children: [
                      buildButton2(12, () {}, false, context),
                      buildButton2(11, () {}, false, context),
                      buildButton2(10, () {}, false, context),
                    ],
                  ),
                ),
                SizedBox(width: 7.0), // 왼쪽 세로 레이아웃과 오른쪽 세로 레이아웃 사이의 간격 조절
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140, // 버튼의 가로 크기를 지정
                      height: 40, // 버튼의 세로 크기를 지정
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  loadMapList(result, prompt1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu, // 아이콘 종류를 지정합니다.
                              color: Colors.grey, // 아이콘의 색상을 설정합니다.
                              size: 24.0, // 아이콘의 크기를 설정합니다.
                            ),
                            Text(
                              ' 목록 보기',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 120.0), // 위젯간 간격 조정을 위한 SizedBox 추가
                    Text(
                      '이오드님 !\n 벌써 60%를 달성했어요 :) \n 백엔드 개발자의 꿈을 향해 나아가는 \n 이오드님의 여정을 응원합니다.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 110.0), // 위젯간 간격 조정을 위한 SizedBox 추가
                    SizedBox(
                      width: 140, // 버튼의 가로 크기를 지정
                      height: 40, // 버튼의 세로 크기를 지정
                      child: ElevatedButton(
                        onPressed: () async {
                          showPopup(context, result);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFBB85FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Text(
                          '활동 등록',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 7.0), // 왼쪽 세로 레이아웃과 오른쪽 세로 레이아웃 사이의 간격 조절
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 정렬
                    mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬 추가
                    children: [
                      buildButton2(4, () {}, false, context),
                      buildButton2(5, () {}, false, context),
                      buildButton2(6, () {}, false, context),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // 버튼들이 왼쪽으로 정렬되어 한 줄로 보이도록 설정
                  children: [
                    buildButton(9, () {}, false, context),
                    buildButton(8, () {}, false, context),
                    buildButton(7, () {}, false, context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
    prom = "$prompt1 관련 자격증 5개만 알려줘.";
  } else {
    prom = "$prompt를 할건데, 번호 매겨서 키워드만 알려줘";
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
