import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Blog",
          style: TextStyle(
            color: AppPallete.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go("/profile");
          },
          icon: Icon(Icons.account_circle_rounded, color: AppPallete.whiteColor,size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final blogBloc = context.read<BlogBloc>();
              final blogAdded = await context.push("/add-blog");
              if (!mounted) return;
              if (blogAdded == true) {
                blogBloc.add(BlogFetchAll());
              }
            },
            icon: Icon(
              CupertinoIcons.add_circled_solid,
              color: AppPallete.secondaryColor,
              size: 30,
            ),
          ),
        ],
        scrolledUnderElevation: 0,
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
              padding: EdgeInsets.only(top: 24,left:16,right: 16 ),
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
    );
  }
}
