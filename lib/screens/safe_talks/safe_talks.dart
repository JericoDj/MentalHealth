import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:flutter/rendering.dart';

class SafeTalksScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const SafeTalksScreen({Key? key, this.onBackToHome}) : super(key: key);

  @override
  _SafeTalksScreenState createState() => _SafeTalksScreenState();
}

class _SafeTalksScreenState extends State<SafeTalksScreen> {
  ScrollController _scrollControllerForYou = ScrollController();
  ScrollController _scrollControllerMyPosts = ScrollController();
  bool _showSearch = true;
  List<Map<String, dynamic>> _approvedPosts = [
    {
      "username": "Alice",
      "time": "2 hrs ago",
      "content": "This is an approved post. Stay positive! 💙",
      "likes": 10,
      "comments": List<Map<String, dynamic>>.generate(20, (index) => {"username": "User$index", "comment": "Comment $index"})
    },
    {
      "username": "Bob",
      "time": "5 hrs ago",
      "content": "Mental health matters. Take care of yourself. 😊",
      "likes": 15,
      "comments": List<Map<String, dynamic>>.generate(20, (index) => {"username": "User$index", "comment": "Comment $index"})
    }
  ];
  List<Map<String, dynamic>> _pendingPosts = [];
  List<Map<String, dynamic>> _myPosts = [];

  @override
  void initState() {
    super.initState();
    _scrollControllerForYou.addListener(() {
      _handleScroll(_scrollControllerForYou);
    });
    _scrollControllerMyPosts.addListener(() {
      _handleScroll(_scrollControllerMyPosts);
    });
    _showKeepItCleanDialog();
  }

  void _showKeepItCleanDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildKeepItCleanDialog(context),
      );
    });
  }

  Widget _buildKeepItCleanDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Welcome to Safe Talk!",
        style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.color1, fontSize: 20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.51, // 50% of screen height
        child: Column(
          children: [

            Text(
              textAlign: TextAlign.center,
              "All together, let's create a warm and supportive mental health community.\n\n"
                  "Share your thoughts, helpful quotes, and motivational words to help inspire and uplift fellow community members. "
                  "Let's cultivate a space where we can all feel safe, heard, and understood.\n",
              style: TextStyle(fontSize: 14),
            ),
            Container(

              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: MediaQuery.of(context).size.height * 0.3, // 50% of screen height
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(MyColors.color2), // Scroll wheel color
                  thickness: MaterialStateProperty.all(6), // Scroll thickness
                  radius: const Radius.circular(10), // Rounded edges
                ),
                child: Scrollbar(
                  thumbVisibility: true, // Always show scrollbar
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Community Rules:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.color1),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, color: Colors.black), // Default text style
                              children: [
                                TextSpan(
                                  text: "1. Respect Everyone: ",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "No cursing, malicious words, or hurtful language. We are here to support each other, so kindness is key!\n\n"),

                                TextSpan(
                                  text: "2. Be Supportive: ",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "Offer advice with empathy, understanding that everyone's journey is different.\n\n"),

                                TextSpan(
                                  text: "3. Stay Positive: ",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "Share content that helps uplift others. Avoid negativity or harmful content.\n\n"),

                                TextSpan(
                                  text: "4. Privacy Matters: ",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "Don't share personal information about others (names, department) when posting content.\n\n"),

                                TextSpan(
                                  text: "5. Be Mindful of Triggers: ",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "Mental health topics can be sensitive. Please be aware and considerate of others' emotions.\n\n"),
                              ],
                            ),
                          ),
                          Text(
                            "Let's keep this space a sanctuary where everyone can express themselves freely and safely. "
                                "Thank you for being a part of Safe Talk!",
                            style: TextStyle(fontSize: 14,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            widget.onBackToHome?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Back to Home",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(color: MyColors.color2, borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Agree",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
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

  void _submitPost(String content) {
    setState(() {
      Map<String, dynamic> post = {
        "username": "You",
        "time": "Just now",
        "content": content,
        "likes": 0,
        "comments": [],
        "pending": true,
      };
      _pendingPosts.insert(0, post);
      _myPosts.insert(0, post);
    });
  }

  void _cancelPendingPost(int index) {
    setState(() {
      _pendingPosts.removeAt(index);
      _myPosts.removeWhere((post) => post["pending"] == true);
    });
  }

  void _likePost(int index, bool isPending, bool isMyPost) {
    setState(() {
      if (isMyPost) {
        _myPosts[index]["likes"] += 1;
      } else if (isPending) {
        _pendingPosts[index]["likes"] += 1;
      } else {
        _approvedPosts[index]["likes"] += 1;
      }
    });
  }

  void openCommentsModal(int index, bool isPending, bool isMyPost) {
    List<Map<String, dynamic>> comments = isMyPost
        ? _myPosts[index]["comments"]
        : isPending
        ? _pendingPosts[index]["comments"]
        : _approvedPosts[index]["comments"];

    int _visibleComments = 7;
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Comments",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                            _visibleComments < comments.length) {
                          setState(() {
                            _visibleComments += 7;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _visibleComments <= comments.length
                            ? _visibleComments + 1
                            : comments.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= comments.length) {
                            return _visibleComments < comments.length
                                ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _visibleComments += 7;
                                    });
                                  },
                                  child: Text(
                                    "Load more",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "End of comments",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            );
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/avatars/Avatar1.jpeg'),
                            ),
                            title: Text(comments[index]["username"]),
                            subtitle: Text(comments[index]["comment"]),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "Report") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Comment reported.")),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(value: "Report", child: Text("Report Comment")),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Add a comment...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.send, color: MyColors.color2),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              setState(() {
                                comments.insert(0, {
                                  "username": "You",
                                  "comment": commentController.text,
                                });
                                commentController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
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
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showSearch ? 60 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
              ),
              const TabBar(
                labelColor: MyColors.color1,
                unselectedLabelColor: Colors.black54,
                indicatorColor: MyColors.color2,
                tabs: [
                  Tab(text: "Feed"),
                  Tab(text: "My Posts"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPostFeed(),
                    _buildMyPostsFeed(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostFeed() {
    return ListView(
      children: [
        _buildPostInput(),
        ..._pendingPosts.map((post) => buildPostItem(post, true, false)),
        ..._approvedPosts.map((post) => buildPostItem(post, false, false)),
      ],
    );
  }

  Widget _buildMyPostsFeed() {
    return ListView(
      children: [
        ..._myPosts.map((post) => buildPostItem(post, post["pending"], true)),
      ],
    );
  }

  Widget _buildPostInput() {
    TextEditingController _postController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(backgroundImage: AssetImage('assets/avatars/Avatar5.jpeg')),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _postController,
              decoration: const InputDecoration(
                hintText: "What's new?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send, color: MyColors.color2),
            onPressed: () {
              if (_postController.text.isNotEmpty) {
                _submitPost(_postController.text);
                _postController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(Map<String, dynamic> post, bool pending, bool isMyPost) {
    int index = isMyPost ? _myPosts.indexOf(post) : pending ? _pendingPosts.indexOf(post) : _approvedPosts.indexOf(post);
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: pending ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(backgroundImage: AssetImage('assets/avatars/Avatar1.jpeg')),
                title: Text(post["username"]),
                subtitle: Text(post["time"]),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Report") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post reported.")));
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: "Report", child: Text("Report Post")),
                  ],
                ),
              ),
              Text(post["content"]),
              if (pending) const Text("Pending Approval", style: TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.favorite_border), onPressed: () => _likePost(index, pending, isMyPost)),
                  Text(post["likes"].toString()),
                  IconButton(icon: const Icon(Icons.comment), onPressed: () => openCommentsModal(index, pending, isMyPost)),
                  Text(post["comments"].length.toString()),
                  if (pending && isMyPost) TextButton(onPressed: () => _cancelPendingPost(index), child: const Text("Cancel")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}