import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/screens/profile5_screen.dart';

class Profile4Screen extends StatelessWidget {
  const Profile4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = Get.arguments;
    String license = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PERPL',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFBB85FF),
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
              Divider(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              SizedBox(height: 5),
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
                endIndent: 136,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '어떤 자격증을 가지고 계신가요?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(),
                          hintText: '지니고 계신 자격증을 알려주세요 :)'),
                      onChanged: (value) {
                        license = value;
                        data['license'] = license;
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '수상경력이 있으신가요?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(),
                          hintText: '있으시면 알려주세요 :)'),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '어학 점수가 몇 점이신가요?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(),
                          hintText: '있으시면 알려주세요 :)'),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                    Get.to(const Profile5Screen(), arguments: data);
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
