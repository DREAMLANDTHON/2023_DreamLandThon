import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/screens/profile1_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PERPL',
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).primaryColor,
            fontFamily: "PottaOneRegular",
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Divider(color: Color.fromARGB(255, 230, 230, 230)),
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
              const SizedBox(height: 5),
              const Divider(color: Color.fromARGB(255, 230, 230, 230)),
              SizedBox(height: screenHeight * 0.07),
              const Text(
                '가입을 완료했어요',
                style: TextStyle(
                  color: Color.fromARGB(255, 80, 80, 80),
                  fontSize: 24,
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              const DefaultTextStyle(
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 80, 80, 80),
                ),
                child: Column(
                  children: [
                    Text('정확한 분석을 위해'),
                    Text('약 2-5분 가량의'),
                    Text('설문조사를 시작합니다'),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(const Profile1Screen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        '프로필 입력하기',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
