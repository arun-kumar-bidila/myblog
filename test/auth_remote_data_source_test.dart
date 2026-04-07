import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myblog/features/auth/data/models/user_model.dart';

class MockDio extends Mock implements Dio {}

class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockDio mockDio;
  late MockStorage mockStorage;
  setUp(() {
    mockDio = MockDio();
    mockStorage = MockStorage();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockDio, mockStorage);
    final baseOptions = BaseOptions(
      headers: {"Content-Type": "application/json"},
    );

    when(() => mockDio.options).thenReturn(baseOptions);
    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockStorage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => "123456");
  });

  group("Auth Remote DataSource-", () {
    group("login user-", () {
      test(
        "given user email and password when login called return user model",
        () async {
          //Arrange
          final email = "arunkumar@gmail.com";
          final password = "123456";

          final mockResponse = Response(
            requestOptions: RequestOptions(path: ""),
            statusCode: 200,
            data: {
              "accessToken": "123456",
              "user": {
                "_id": "122",
                "name": "arun",
                "email": "arunkumar@gmail.com",
              },
            },
          );

          when(
            () => mockDio.post(any(), data: any(named: 'data')),
          ).thenAnswer((_) async => mockResponse);

          final result = await authRemoteDataSourceImpl.loginWithEmailPassword(
            email: email,
            password: password,
          );
          expect(result, isA<UserModel>());
        },
      );

      test("when response is not 200", () async {
        //Arrange
        final email = "arunkumar@gmail.com";
        final password = "123456";
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 500,
          data: {"message": "Internal Server Error"},
        );

        when(
          () => mockDio.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => mockResponse);

        final result = authRemoteDataSourceImpl.loginWithEmailPassword(
          email: email,
          password: password,
        );
        expect(result, throwsA(isA<ServerException>()));
      });
    });

    group("signup user -", () {
      test("when is signup sends 201 response return usermodel", () async {
        final name = "arun";
        final email = "arun";
        final password = 'arun';
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 201,
          data: {
            "accessToken": "aaaa",
            "user": {
              "_id": "122",
              "name": "arun",
              "email": "arunkumar@gmail.com",
            },
          },
        );
        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = await authRemoteDataSourceImpl.signUpWithEmailPassword(
          email: email,
          name: name,
          password: password,
        );

        expect(result, isA<UserModel>());
      });

      test("when signup status code is not 201", () {
        final name = "arun";
        final email = "arun";
        final password = 'arun';
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 500,
          data: {"message": "Internal Server Error"},
        );
        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = authRemoteDataSourceImpl.signUpWithEmailPassword(
          name: name,
          email: email,
          password: password,
        );
        expect(result, throwsA(isA<ServerException>()));
      });
    });
  });

  group("get user data -", () {
    test("when userdata is fetched response of 200", () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 200,
        data: {
          "accessToken": "aaaa",
          "user": {
            "_id": "122",
            "name": "arun",
            "email": "arunkumar@gmail.com",
          },
        },
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);
      final result = await authRemoteDataSourceImpl.getUserData();

      expect(result, isA<UserModel>());
    });

    test("when userdata throws status other than 200", () async {
      //Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 500,
        data: {"message": "Error"},
      );
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);
      final result = authRemoteDataSourceImpl.getUserData();
      expect(result, throwsA(isA<ServerException>()));
    });
  });


}
