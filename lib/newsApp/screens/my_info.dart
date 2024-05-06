import 'package:flutter/material.dart';

class MyInformation extends StatelessWidget {
  const MyInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Image.asset('images/new.png'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              " A news application built in Flutter provides a user-friendly interface for accessing up-to-date news articles from varioussources.",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15, wordSpacing: 10),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'images/insta.png',
                  height: 50,
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'images/linkedin.png',
                    height: 30,
                  )),
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'images/github.png',
                    height: 35,
                  )),
            ],

          ),
          SizedBox(height: 30,),
          Text("This apk is develop by Rahul Sharma",style: TextStyle(fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
