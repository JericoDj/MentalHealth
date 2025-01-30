import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class SafeTalksScreen extends StatefulWidget {
  @override
  _SafeTalksScreenState createState() => _SafeTalksScreenState();
}

class _SafeTalksScreenState extends State<SafeTalksScreen> {
  ScrollController _scrollControllerForYou = ScrollController();
  ScrollController _scrollControllerFollowing = ScrollController();
  bool _showSearch = true;

  @override
  void initState() {
    super.initState();
    _scrollControllerForYou.addListener(() {
      _handleScroll(_scrollControllerForYou);
    });
    _scrollControllerFollowing.addListener(() {
      _handleScroll(_scrollControllerFollowing);
    });
  }

  void _handleScroll(ScrollController controller) {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showSearch) {
        setState(() {
          _showSearch = false;
        });
      }
    } else if (controller.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showSearch) {
        setState(() {
          _showSearch = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(height: 10,),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _showSearch ? 60 : 0,
                child: ClipRect(  // Clipping to ensure smooth hiding
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: _showSearch ? 1.0 : 0.0,  // Smoothly hide content
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    NestedScrollView(
                      controller: _scrollControllerForYou,
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverToBoxAdapter(child: _buildPostInput()),
                        ];
                      },
                      body: _buildPostList(),
                    ),
                    NestedScrollView(
                      controller: _scrollControllerFollowing,
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverToBoxAdapter(child: _buildPostInput()),
                        ];
                      },
                      body: _buildPostList(),
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

  Widget _buildPostList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildPostItem();
      },
    );
  }

  Widget _buildPostInput() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/Avatar5.jpeg'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "What's new?",

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPostItem() {
    return Card(
elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10,))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatars/Avatar1.jpeg'),
                ),
                title: Text('User Name'),
                subtitle: Text('2 hrs ago'),
                trailing: Icon(Icons.more_horiz),
              ),
              Text(
                'This is an example of a social post caption. #MentalHealth',
              ),
              SizedBox(height: 10),
              //Image.network('https://via.placeholder.com/600x400'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 5),
                      Text('120'),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 5),
                      Text('34'),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
