import 'package:flutter/material.dart';
import 'package:sadya/receipe_detail.dart';
import 'content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: Content.content.length,
              itemBuilder: (BuildContext context, int index) {
                String imgurl = Content.content[index]['imgUrl'];
                print(imgurl);
                return GridView.count(
                  crossAxisCount: 2,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text(Content.content[index]['title']),
                      subtitle: Container(
                        height: 100,
                        width: 100,
                        child: Image(
                            image: NetworkImage(imgurl), fit: BoxFit.fill),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      title: Content.content[index]['title'],
                                      imgurl: imgurl,
                                  dscption: Content.content[index]['description'],
                                    )));
                      },
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
