import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/screens/profile2_screen.dart';

class Profile1Screen extends StatelessWidget {
  const Profile1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    String wishJob = '';
    String wishCompanyType = '';
    Map<String, String> data = {};

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
            const SizedBox(height: 5),
            const Divider(
              color: Color(0xFFBB85FF),
              thickness: 3.5,
              // 총 6페이지 세로는 400정도 : 66씩
              endIndent: 334,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '희망 직종을 알려주세요',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: '희망 직종을 입력해주세요 :)'),
                    onChanged: (value) {
                      wishJob = value;
                      data["wishJob"] = wishJob;
                    },
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '희망 기업의 종류를 알려주세요 \nEX) 대기업,스타트업...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: '희망 기업의 종류를 입력해주세요 :)'),
                    onChanged: (value) {
                      wishCompanyType = value;
                      data["wishCompanyType"] = wishCompanyType;
                    },
                  ),
                ],
              ),
            ),
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
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // 구현해야함
                    Get.to(const Profile2Screen(), arguments: data);
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
