import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _showSearch ? 60 : 0,
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
          TabBar(
            tabs: [
              Tab(text: 'For You'),
              Tab(text: 'Following'),
            ],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "What's new?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.gif),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Text('User Name'),
              subtitle: Text('2 hrs ago'),
              trailing: Icon(Icons.more_horiz),
            ),
            Text(
              'This is an example of a social post caption. #MentalHealth',
            ),
            SizedBox(height: 10),
            Image.network('https://via.placeholder.com/600x400'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 5),
                    Text('120'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment),
                    SizedBox(width: 5),
                    Text('34'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 5),
                    Text('Share'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
