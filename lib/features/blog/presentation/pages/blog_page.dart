import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';
import 'package:myblog/features/blog/presentation/pages/add_new_blog.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, SignupPage.route());
          },
          icon: Icon(Icons.logout),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlog.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
