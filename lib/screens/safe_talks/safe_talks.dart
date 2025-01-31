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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Community Guidelines",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.onBackToHome?.call();
            },
            child: const Icon(
              Icons.close,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      content: const Text(
        "All posts are reviewed to maintain a supportive environment. "
            "Please keep discussions respectful and avoid hate comments.",
      ),
      actionsAlignment: MainAxisAlignment.end,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Agree",
              style: TextStyle(
                fontSize: 16,
                color: MyColors.color1,
                fontWeight: FontWeight.w600,
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