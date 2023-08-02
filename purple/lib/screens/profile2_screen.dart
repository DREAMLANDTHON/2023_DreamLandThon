import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/screens/profile3_screen.dart';

class Profile2Screen extends StatefulWidget {
  const Profile2Screen({super.key});

  @override
  State<Profile2Screen> createState() => _Profile2ScreenState();
}

class _Profile2ScreenState extends State<Profile2Screen> {
  bool isMajor = true;
  String finalEdBackground = '';
  String whatCollege = '';
  List<String> stuitems = ['학부생', '졸업생', '휴학생'];
  String selectedStuItem = '학부생';
  List<String> collegeItems = [
    '인문계열',
    '사회계열',
    '교육계열',
    '공학계열',
    '자연계열',
    '의약계열',
    '예체능계열'
  ];
  String selectedCollegeItem = '인문계열';
  Map<String, String> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
      body: Center(
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
            const Divider(
              color: Color(0xFFBB85FF),
              thickness: 3.5,
              endIndent: 268,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '전공자 이신가요? 비전공자 이신가요?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isMajor = true;
                                data['isMajor'] = "맞아";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isMajor
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              elevation: 0,
                              side: BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                            ),
                            child: Text(
                              '전공자',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isMajor = false;
                                data['isMajor'] = "아니야";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isMajor
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              elevation: 0,
                              side: BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                            ),
                            child: Text(
                              '비전공자',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Text(
                      '최종 학력이 어떻게 되시나요?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 140,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: selectedStuItem,
                          items: stuitems.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            finalEdBackground = value!;
                            data['finalEdBackground'] = finalEdBackground;
                            setState(() {
                              selectedStuItem = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '대학 계열을 알려주세요',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 130,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: selectedCollegeItem,
                          items: collegeItems.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            whatCollege = value!;
                            data['whatCollege'] = whatCollege;
                            setState(() {
                              selectedCollegeItem = value;
                            });
                          },
                        )
                      ],
                    ),
                  )
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
                    Get.to(const Profile3Screen(), arguments: data);
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
