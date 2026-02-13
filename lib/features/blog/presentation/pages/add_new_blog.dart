import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/core/utils/pick_image.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_editor.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlog());
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<String> selectedTopics = [];
  File? image;

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
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Blog"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        width: .infinity,
                      
                        child: Image.file(image!,fit: BoxFit.cover,),
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
        
                        child: Container(
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
                      ["Technology", "Business", "Programming", "Entertainment"]
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
                                      : BorderSide(color: AppPallete.borderColor),
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
              BlogEditor(hintText: "Blog Title", controller: titleController),
              SizedBox(height: 15),
              BlogEditor(hintText: "Blog Content", controller: contentController),
            ],
          ),
        ),
      ),
    );
  }
}
