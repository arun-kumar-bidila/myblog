import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/notification/notification_handler.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<String> blogCategories = [
    "Technology",
    "Business",
    "Programming",
    "Entertainment",
  ];
  String selectedBlogCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    NotificationHandler.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationHandler.handleInitialMessage(context);
    });
    context.read<BlogBloc>().add(BlogFetchAll());
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Future<void> _onRefresh() async {
    context.read<BlogBloc>().add(BlogFetchAll());
  }

  List<Blog> _applyFilters() {
    List<Blog> blogs = [];
    final blogState = context.read<BlogBloc>().state;
    if (blogState is BlogDisplaySuccess) {
      blogs = blogState.blogs;
      if (selectedBlogCategory == 'Technology') {
        blogs = blogs
            .where((blog) => blog.selectedTopics.contains(selectedBlogCategory))
            .toList();
      } else if (selectedBlogCategory == 'Business') {
        blogs = blogs
            .where((blog) => blog.selectedTopics.contains(selectedBlogCategory))
            .toList();
      } else if (selectedBlogCategory == 'Programming') {
        blogs = blogs
            .where((blog) => blog.selectedTopics.contains(selectedBlogCategory))
            .toList();
      } else if (selectedBlogCategory == 'Entertainment') {
        blogs = blogs
            .where((blog) => blog.selectedTopics.contains(selectedBlogCategory))
            .toList();
      }

      final searchQuery = _searchController.text.trim().toLowerCase();
      if (searchQuery.isNotEmpty) {
        blogs = blogs.where((blog) {
          return blog.title.toLowerCase().contains(searchQuery);
        }).toList();
      }
      return blogs;
    } else {
      return blogs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Blog",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go("/profile");
          },
          icon: Icon(Icons.account_circle_rounded, size: 30),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16).copyWith(bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppPallete.borderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 20, color: AppPallete.secondaryColor),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Search Blog",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: blogCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBlogCategory =
                            selectedBlogCategory == blogCategories[index]
                            ? 'All'
                            : blogCategories[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedBlogCategory == blogCategories[index]
                              ? AppPallete.transparentColor
                              : AppPallete.borderColor,
                          width: 1,
                        ),
                        color: selectedBlogCategory == blogCategories[index]
                            ? AppPallete.secondaryColor
                            : AppPallete.transparentColor,
                      ),
                      child: Text(
                        blogCategories[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: BlocConsumer<BlogBloc, BlogState>(
                listener: (context, state) {
                  if (state is BlogFailure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return Loader();
                  } else if (state is BlogDisplaySuccess) {
                    final blogs = _applyFilters();
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      itemCount: blogs.length,
                      itemBuilder: (context, index) {
                        final blog = blogs[index];
              
                        return BlogCard(blog: blog);
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
