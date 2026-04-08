import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/profile/data/datasources/profile_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late ProfileRemoteDatasourceImpl profileRemoteDatasourceImpl;
  setUp(() {
    mockDio = MockDio();
    profileRemoteDatasourceImpl = ProfileRemoteDatasourceImpl(mockDio);
  });

  group("profile remote data source --", () {
    group("change password --", () {
      late String currentPassword;
      late String newPassword;
      setUp(() {
        currentPassword = "some";
        newPassword = "new";
      });

      test("when the change password successful", () async {
        //Arrange
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 200,
          data: {"message": "password change successful"},
        );
        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = await profileRemoteDatasourceImpl.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

        expect(result, isA<String>());
      });

      test("when the change password is not successful", () {
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 500,
          data: {"message": "failed to change password"},
        );

        when(
          () => mockDio.post(any(), data: any(named: "data")),
        ).thenAnswer((_) async => mockResponse);

        final result = profileRemoteDatasourceImpl.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

        expect(result, throwsA(isA<ServerException>()));
      });
    });
  });
}
