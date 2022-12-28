import 'dart:convert';
import 'package:audio_player/detail_audio_page.dart';
import 'package:audio_player/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/pop_books.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late List popularBooks;
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async{
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books = json.decode(s);
      });
    });
  }


  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.black,
      child: SafeArea(
        child: Scaffold(

          body: Container(
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageIcon(AssetImage("img/menu.png"), color: Colors.white),
                      Row(
                        children: [
                          Icon(Icons.search, size: 35, color: Colors.white),
                          SizedBox(width: 10,),
                          Icon(Icons.notifications, size: 35, color: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("Popular Books",
                    style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                          left: -20,
                          right: 0,
                          child:  Container(
                            height: 180,
                            child: PageView.builder(
                                controller: PageController(viewportFraction: 0.8),
                                itemCount: popularBooks==null?0:popularBooks.length,
                                itemBuilder: (_, i){
                                  return
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=> PopBooks(popularbooksData: popularBooks, index: i))
                                        );
                                      },
                                      child: Container(
                                        height: 180,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: AssetImage(popularBooks[i]["img"]),
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                      ),
                                    );


                                }),
                          ) ,
                      )
                    ],
                  ),
                ),
                Expanded(child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll){

                    return[
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.2),
                                //     blurRadius: 7,
                                //     offset: Offset(0,0),
                                //   )
                                // ]
                              ),
                              tabs: [
                                AppTabs(color: Colors.orange, text: "New"),
                                AppTabs(color: Colors.red, text: "Popular"),
                                AppTabs(color: Colors.blue, text: "Trending"),
                            ],
                          ),
                        ),
                      ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: books==null?0 : books.length,
                          itemBuilder: (_,i){
                        return
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData: books, index: i))
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     blurRadius: 2,
                                  //     offset: Offset(0,0),
                                  //     color:Colors.grey.withOpacity(0.2),
                                  //   )
                                  // ]
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[i]["img"]),
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 24, color: Colors.orange,),
                                            SizedBox(width: 5,),
                                            Text(books[i]["rating"], style: TextStyle(color: Colors.yellowAccent),)
                                          ],
                                        ),
                                        Text(books[i]["title"], style: TextStyle(fontSize: 16, fontFamily: 'Avenir', fontWeight: FontWeight.bold,color: Colors.white), ),
                                        Text(books[i]["text"], style: TextStyle(fontSize: 14, fontFamily: 'Avenir', color: Colors.white.withOpacity(0.8),)),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: 60,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.blue.withOpacity(0.8),
                                          ),
                                          child:
                                          Text("Love", style: TextStyle(fontSize: 12, fontFamily: 'Avenir', color: Colors.white),),
                                          alignment: Alignment.center,
                                        ),


                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );

                      }),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                    ],
                  ),
                ))

              ],
            ),
          )

        ),
      ),

    );
  }
}
