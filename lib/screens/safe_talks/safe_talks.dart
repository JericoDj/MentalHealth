import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:flutter/rendering.dart';

import '../../utils/storage/user_storage.dart';

class SafeSpaceScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const SafeSpaceScreen({Key? key, this.onBackToHome}) : super(key: key);

  @override
  _SafeSpaceScreenState createState() => _SafeSpaceScreenState();
}

class _SafeSpaceScreenState extends State<SafeSpaceScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserStorage _userStorage = UserStorage(); // Instantiate UserStorage here



  List<Map<String, dynamic>> _approvedPosts = [];
  List<Map<String, dynamic>> _pendingPosts = [];
  List<Map<String, dynamic>> _myPosts = [];
  @override
  void initState() {
    super.initState();

    _fetchPosts();

    _showKeepItCleanDialog();
  }

  void _fetchPosts() {
    final String? username = _userStorage.getUsername(); // Retrieve username from local storage
    if (username == null) return; // If there's no username, exit early

    _firestore.collection('safeSpace').doc('posts').collection('userPosts')
        .snapshots().listen((snapshot) {
      List<Map<String, dynamic>> approved = [];
      List<Map<String, dynamic>> pending = [];
      List<Map<String, dynamic>> myPosts = [];

      for (var doc in snapshot.docs) {
        var postData = doc.data();
        postData['id'] = doc.id;
        postData['comments'] ??= [];

        // Compare username instead of userId
        if (postData["status"] == "pending") {
          pending.add(postData);
        }
        else if (postData["status"] == "approved") {
          approved.add(postData);
        }

        // Check if the username matches the current user's username
        if (postData["username"] == username) {
          myPosts.add(postData);
        }
      }

      setState(() {
        _approvedPosts = approved;
        _pendingPosts = pending;
        _myPosts = myPosts;
      });

      print("Fetched ${_approvedPosts.length} approved posts");
      print("Fetched ${_pendingPosts.length} pending posts");
    });
  }



  // ────────────────────────────────────────────────
  // 📌 SUBMIT A NEW POST
  // ────────────────────────────────────────────────
  void _submitPost(String content) async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return;

    String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Retrieve username from local storage
    String? username = _userStorage.getUsername();

    if (username == null || username.isEmpty) {
      username = "Anonymous";  // Fallback in case username is not found
    }

    Map<String, dynamic> post = {
      "userId": uid,
      "username": username, // Use the local username
      "time": now,
      "content": content,
      "likes": [], // Likes will be a list of UIDs instead of count
      "comments": [],
      "status": "pending",
    };

    try {
      DocumentReference docRef = await _firestore
          .collection('safeSpace')
          .doc('posts')
          .collection('userPosts')
          .add(post);

      print('Post submitted successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error submitting post: $e');
    }
  }




  // ────────────────────────────────────────────────
// 📌 LIKE A POST
// ────────────────────────────────────────────────
  void _likePost(String postId, List<dynamic> currentLikes) async {
    String? uid = _auth.currentUser?.uid; // Get the UID of the logged-in user
    if (uid == null) return; // If no UID, exit early

    DocumentReference postRef = _firestore
        .collection('safeSpace')
        .doc('posts')
        .collection('userPosts')
        .doc(postId);

    if (currentLikes.contains(uid)) {
      // If the user has already liked, remove their UID
      await postRef.update({
        "likes": FieldValue.arrayRemove([uid]) // Remove the UID from likes array
      });
    } else {
      // If the user hasn't liked, add their UID
      await postRef.update({
        "likes": FieldValue.arrayUnion([uid]) // Add the UID to likes array
      });
    }
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
        "Welcome to Safe Community!",
        style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.color1, fontSize: 20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.51, // 50% of screen height
        child: Column(
          children: [

            Text(
              textAlign: TextAlign.start,
              "All together, let's create a warm and supportive mental health community.\n\n"
                  "Share your thoughts, helpful quotes, and motivational words to help inspire and luminara fellow community members. "
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
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
        ),
      ],
    );
  }



  void _cancelPendingPost(String postId) async {
    try {
      await _firestore
          .collection('safeSpace')
          .doc('posts')
          .collection('userPosts')
          .doc(postId)
          .delete();

      print("Pending post deleted: $postId");
    } catch (e) {
      print("Error deleting pending post: $e");
    }
  }

  void _deleteMyPost(String postId) async {
    try {
      await _firestore
          .collection('safeSpace')
          .doc('posts')
          .collection('userPosts')
          .doc(postId)
          .delete();

      print("Post deleted: $postId");
    } catch (e) {
      print("Error deleting post: $e");
    }
  }




  void openCommentsModal(int index, bool isPending, bool isMyPost) {
    String? username = _userStorage.getUsername(); // Get username from local storage
    if (username == null) return;

    // 🔹 Get correct list of comments
    List<dynamic> comments = isMyPost
        ? _myPosts[index]["comments"] ?? []
        : isPending
        ? _pendingPosts[index]["comments"] ?? []
        : _approvedPosts[index]["comments"] ?? [];

    TextEditingController commentController = TextEditingController();
    int _visibleComments = 7;

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
                  // 🔹 Title and Close Button
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

                  // 🔹 Comments List
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

                          // 🔹 Display comment
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/avatars/Avatar1.jpeg'),
                            ),
                            title: Text(comments[index]["username"] ?? "Unknown"), // Use username
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comments[index]["comment"] ?? ""),
                                Text(
                                  comments[index]["time"] ?? "",
                                  style: TextStyle(fontSize: 10, color: Colors.grey),
                                ),
                              ],
                            ),
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

                  // 🔹 Input Field for New Comment
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

                        // 🔹 Add Comment Button
                        IconButton(
                          icon: Icon(Icons.send, color: MyColors.color2),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              _addComment(
                                postId: _approvedPosts[index]["id"],
                                comment: commentController.text,
                              );
                              setState(() {
                                comments.insert(0, {
                                  "username": username, // Save username instead of uid
                                  "time": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                                  "comment": commentController.text,
                                });
                              });
                              commentController.clear();
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


  void _addComment({required String postId, required String comment}) async {
    String? username = _userStorage.getUsername(); // Get username from local storage
    if (username == null) return;

    String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Map<String, dynamic> newComment = {
      "username": username, // Use username instead of uid
      "time": now,
      "comment": comment,
    };

    try {
      await _firestore.collection('safeSpace').doc('posts').collection('userPosts').doc(postId).update({
        "comments": FieldValue.arrayUnion([newComment]),
      });

      print("Comment added: $comment");
    } catch (e) {
      print("Error adding comment: $e");
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
              const SizedBox(height: 10),

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
        ..._myPosts.map((post) => buildPostItem(
          post,
          post["status"] == "pending", // 🔹 Properly checking "status" instead of "pending"
          true,
        )),
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
    String? username = post["username"]; // Use username from the post data

    // 🔹 Ensure "likes" is always a list
    List<dynamic> likes = (post["likes"] is List) ? post["likes"] : [];

    bool hasLiked = likes.contains(username); // ✅ Check if user has already liked using username

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
                title: Text(username ?? "Anonymous"), // Display username instead of uid
                subtitle: Text(post["time"] ?? "Unknown time"),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Report") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Post reported.")),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: "Report", child: Text("Report Post")),
                  ],
                ),
              ),
              Text(post["content"] ?? ""),
              if (pending)
                const Text("Pending Approval", style: TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 10),
              Row(
                children: [
                  // 🔹 Like Button with Toggle Feature
                  IconButton(
                    icon: Icon(
                      hasLiked ? Icons.favorite : Icons.favorite_border,
                      color: hasLiked ? Colors.red : null, // ✅ Highlight if liked
                    ),
                    onPressed: () => _likePost(post["id"] ?? "", likes),
                  ),
                  Text(likes.length.toString()), // ✅ Show total likes

                  // 🔹 Comments Section
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () => openCommentsModal(
                      isMyPost ? _myPosts.indexOf(post) : pending ? _pendingPosts.indexOf(post) : _approvedPosts.indexOf(post),
                      pending,
                      isMyPost,
                    ),
                  ),
                  Text((post["comments"] ?? []).length.toString()),

                  // 🔹 Delete (if it's my post)
                  if (isMyPost)
                    TextButton(
                      onPressed: () => _deleteMyPost(post["id"]),
                      child: const Text("Delete"),
                    ),

                  // 🔹 Cancel (only for pending posts)
                  if (pending && isMyPost)
                    TextButton(
                      onPressed: () => _cancelPendingPost(post["id"]),
                      child: const Text("Cancel"),
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
