import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:myblog/features/blog/data/models/blog_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late BlogRemoteDataSourceImpl blogRemoteDataSourceImpl;
  late MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    blogRemoteDataSourceImpl = BlogRemoteDataSourceImpl(mockDio);
  });
  group("given blogRemoteDateSource", () {
    group("given uploadBlogImage", () {
      test("when upload is successful", () async {
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 200,
          data: {"imageUrl": "someurl"},
        );

        final file = File("dummy_image.jpg");
        await file.writeAsBytes([0, 1, 2, 3]);

        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = await blogRemoteDataSourceImpl.uploadBlogImage(
          image: file,
        );
        expect(result, isA<String>());
        await file.delete();
      });

      test("when upload is failed-", () async {
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 500,
          data: {"message": "error"},
        );
        final file = File("dummy_image.jpg");
        await file.writeAsBytes([0, 1, 2, 3]);
        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = blogRemoteDataSourceImpl.uploadBlogImage(image: file);
        expect(result, throwsA(isA<ServerException>()));
        await file.delete();
      });
    });
  });

  group("given uploadblog-", () {
    test("when the upload blog is success", () async {
      final blog = BlogModel(
        id: "id",
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        posterId: "posterId",
        selectedTopics: ["Technology"],
        updated: DateTime.parse("2024-04-07"),
      );
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 200,
        data: {
          "blog": {
            "_id": "some",
            "title": "my blog",
            "content": "this is my blog content",
            "imageUrl":
                "https://res.cloudinary.com/duoenlwuj/image/upload/v1771220021/hhttyvq6pdwp40n3olzu.png",
            "posterId": "698d8264c821712c4b4fd92f",
            "selectedTopics": ["Technology"],
            "updated": "2026-02-16T10:30:00Z",
          },
        },
      );

      when(
        () => mockDio.post(any(), data: any(named: "data")),
      ).thenAnswer((_) async => mockResponse);

      final result = await blogRemoteDataSourceImpl.uploadBlog(blog: blog);

      expect(result, isA<BlogModel>());
    });

    test("when the upload blog is failure", () async {
      final blog = BlogModel(
        id: "id",
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        posterId: "posterId",
        selectedTopics: ["Technology"],
        updated: DateTime.parse("2024-04-07"),
      );

      final mockResponse = Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 500,
        data: {"messae": "error"},
      );

      when(
        () => mockDio.post(any(), data: any(named: "data")),
      ).thenAnswer((_) async => mockResponse);

      final result = blogRemoteDataSourceImpl.uploadBlog(blog: blog);

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  test("get all blogs is success", () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: ""),
      statusCode: 200,
      data: {
        "blogs": {
          {
            "_id": "some",
            "title": "my blog",
            "content": "this is my blog content",
            "imageUrl":
                "https://res.cloudinary.com/duoenlwuj/image/upload/v1771220021/hhttyvq6pdwp40n3olzu.png",
            "posterId": "698d8264c821712c4b4fd92f",
            "selectedTopics": ["Technology"],
            "updated": "2026-02-16T10:30:00Z",
          },
          {
            "_id": "some",
            "title": "my blog",
            "content": "this is my blog content",
            "imageUrl":
                "https://res.cloudinary.com/duoenlwuj/image/upload/v1771220021/hhttyvq6pdwp40n3olzu.png",
            "posterId": "698d8264c821712c4b4fd92f",
            "selectedTopics": ["Technology"],
            "updated": "2026-02-16T10:30:00Z",
          },
        },
      },
    );

    when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

    final result = await blogRemoteDataSourceImpl.getAllBlogs();

    expect(result, isA<List<BlogModel>>());
  });

  test("get all blogs is failure", () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: ""),
      statusCode: 500,
      data: {"message": "this is a error"},
    );

    when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

    final result = blogRemoteDataSourceImpl.getAllBlogs();

    expect(result, throwsA(isA<ServerException>()));
  });
}
