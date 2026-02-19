import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/core/common/loader.dart';
import 'package:myblog/core/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/core/utils/pick_image.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_editor.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<String> selectedTopics = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  Future<void> selectImage() async {
    final pickedImg = await pickImage();
    if (pickedImg != null) {
      setState(() {
        image = pickedImg;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTopics.isNotEmpty) {
      final userState = context.read<AppUserCubit>().state;
      if (userState is AppUserLoggedIn) {
        final posterId = userState.user.id;
        context.read<BlogBloc>().add(
          BlogUpload(
            image: image!,
            title: titleController.text,
            content: contentController.text,
            selectedTopics: selectedTopics,
            posterId: posterId,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Blog"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: uploadBlog, icon: Icon(Icons.done_rounded)),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          } else if (state is BlogUploadSuccess) {
            context.pop(true);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              width: .infinity,

                              child: Image.file(image!, fit: BoxFit.cover),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                radius: Radius.circular(10),
                                color: AppPallete.borderColor,
                                strokeCap: .round,
                                dashPattern: [10, 4],
                              ),

                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open, size: 40),
                                    SizedBox(height: 15),
                                    Text(
                                      "Select your image",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  "Technology",
                                  "Business",
                                  "Programming",
                                  "Entertainment",
                                ]
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Chip(
                                        label: Text(e),
                                        side: selectedTopics.contains(e)
                                            ? null
                                            : BorderSide(
                                                color: AppPallete.borderColor,
                                              ),
                                        color: selectedTopics.contains(e)
                                            ? WidgetStatePropertyAll(
                                                AppPallete.gradient1,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 15),
                    BlogEditor(
                      hintText: "Blog Title",
                      controller: titleController,
                    ),
                    SizedBox(height: 15),
                    BlogEditor(
                      hintText: "Blog Content",
                      controller: contentController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
