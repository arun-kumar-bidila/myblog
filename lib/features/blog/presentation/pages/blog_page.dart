import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/core/common/loader.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/pages/login_page.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/blog/presentation/pages/add_new_blog.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogOutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(),
            (route) => false,
          );
        }
        if (state is AuthLogOutFailure) {
          showSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Blog App"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthUserLogOut());
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
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loader();
            } else if (state is BlogDisplaySuccess) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];

                  return BlogCard(blog: blog);
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
