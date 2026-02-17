int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final time = wordCount / 225;
  return time.ceil();
}
