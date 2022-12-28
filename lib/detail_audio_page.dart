import 'package:audio_player/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({Key? key, this.booksData, required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {

  late AudioPlayer advancedPlayer;

  @override
  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
                left: 0.0,
                right: 0.0,
                height: screenheight/3,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.blueGrey,
                        ],
                        tileMode: TileMode.mirror,
                        stops: [
                          0.1,
                          0.6,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                  ),
                )),
            Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    onPressed: (){
                      advancedPlayer.stop();
                      Navigator.of(context).pop();
                      },
                  ),

                  actions: [
                    IconButton(
                      icon: Icon(Icons.search,color: Colors.white,),
                      onPressed: (){},
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
            Positioned(
                left: 0,
                right: 0,
                top: screenheight*0.2,
                height: screenheight*0.36,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                      color: Colors.white,
                      offset:  const Offset(0, 0),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                    )],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenheight*0.1,),
                      Text(this.widget.booksData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                        color: Colors.black,
                      ),
                      ),
                      Text(this.widget.booksData[this.widget.index]["text"],
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),),
                      AudioFile(advancedPlayer: advancedPlayer, audioPath: this.widget.booksData[this.widget.index]["audio"]),
                    ],
                  ),
                )),
            Positioned(
                top: screenheight*0.12,
                left: (screenwidth-140)/2,
                right: (screenwidth-140)/2,
                height: screenheight*0.16,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2.0),
                    color: Colors.cyanAccent.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        offset: Offset(0, 0),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.0),
                        image: DecorationImage(
                          image: AssetImage(this.widget.booksData[this.widget.index]["img"]),
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
