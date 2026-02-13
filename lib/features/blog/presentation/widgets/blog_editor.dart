import 'package:flutter/material.dart';

class BlogEditor extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const BlogEditor({super.key,required this.hintText,required this.controller});

  @override
  State<BlogEditor> createState() => _BlogEditorState();
}

class _BlogEditorState extends State<BlogEditor> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        
      ),
      maxLines: null,
    );
  }
}
