import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myblog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myblog/features/auth/data/models/user_model.dart';

class MockDio extends Mock implements Dio {}

class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockDio mockDio;
  late MockStorage mockStorage;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockStorage();

    // ensure options getter returns a writable BaseOptions instance
    when(() => mockDio.options).thenReturn(BaseOptions(headers: {}));

    dataSource = AuthRemoteDataSourceImpl(mockDio, mockStorage);
  });

  test('login success should store token and return user model', () async {
    // Arrange
    // match the JSON structure expected by UserModel.fromJson
    final responsePayload = {
      "accessToken": "test_token",
      "user": {"_id": "1", "email": "test@mail.com", "name": "arun"},
    };

    when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
      (_) async => Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async => Future.value());

    when(
      () => mockStorage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => "test_token");

    // Act
    final result = await dataSource.loginWithEmailPassword(
      email: "test@mail.com",
      password: "123456",
    );

    // Assert
    expect(result, isA<UserModel>());
    expect(result.email, "test@mail.com");
    expect(mockDio.options.headers["Authorization"], "Bearer test_token");

    // Verify interactions
    verify(
      () => mockStorage.write(key: "token", value: "test_token"),
    ).called(1);
  });
}
