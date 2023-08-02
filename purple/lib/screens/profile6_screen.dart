import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/loadmap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

var apiKey = dotenv.env['apiKey'];
var apiUrl = dotenv.env['apiUrl'];

class Profile6Screen extends StatelessWidget {
  const Profile6Screen({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, String> data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PERPL',
          style: TextStyle(
            color: Color(0xFFBB85FF),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            const SizedBox(height: 5),
            const Text(
              "프로필 작성하기",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff665e72),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Divider(
              color: Color(0xFFBB85FF),
              thickness: 3.5,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '수고하셨습니다 !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF675E72),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '곧 회원님의 맞춤 로드맵이 생성됩니다',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF9882B4),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                        color: Color.fromARGB(255, 230, 230, 230)),
                  ),
                  child: const Text(
                    '이전',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const SizedBox(height: 50),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    String combinedPrompt =
                        "내 꿈은 ${data['wishJob']}  이야. 난 ${data['wishCompanyType']}  에 입사하고 싶어. 난 전공자가 ${data['isMajor']} . 나는 ${data['finalEdBackground']}을 스펙으로 가지고 싶어. 난 가지고 있는 자격증이 ${data['license']}이야. 난 ${data['where']}  에 살고, 내 취미는 ${data['hobby']}  야.";
                    String result = await generateText(combinedPrompt);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResultPage(result, data['wishJob']!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                  ),
                  child:
                      const Text('다음', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> generateText(String prompt) async {
  Map<String, String> data = Get.arguments;
  final response = await http.post(
    Uri.parse(apiUrl!),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': "$prompt 이런 나를 위해서 로드맵 순서를 정해서 알려줘. 근데 오타없이 키워드만 간단히.",
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
