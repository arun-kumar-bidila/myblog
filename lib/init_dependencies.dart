import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:myblog/common/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/core/network/connection_checker.dart';
import 'package:myblog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myblog/features/auth/data/repository/auth_repository_impl.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';
import 'package:myblog/features/auth/domain/usecases/get_user.dart';
import 'package:myblog/features/auth/domain/usecases/user_login.dart';
import 'package:myblog/features/auth/domain/usecases/user_logout.dart';
import 'package:myblog/features/auth/domain/usecases/user_signup.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:myblog/features/blog/data/repostories/blog_repository_impl.dart';
import 'package:myblog/features/blog/domain/repositores/blog_repository.dart';
import 'package:myblog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:myblog/features/blog/domain/usecases/upload_blog.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:myblog/features/profile/data/repository/profile_repository_impl.dart';
import 'package:myblog/features/profile/domain/repository/profile_repository.dart';
import 'package:myblog/features/profile/domain/usecases/change_password.dart';
import 'package:myblog/features/profile/presentation/bloc/profile_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://myblogserver-55ix.onrender.com",
      headers: {"Content-Type": "application/json"},
      validateStatus: (status) => true,
    ),
  );

  final storage = FlutterSecureStorage();

  serviceLocator.registerLazySingleton(() => dio);
  serviceLocator.registerLazySingleton(() => storage);
  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  _initAuth();
  _initBlog();
  _initProfile();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => UserSignup(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => GetUser(serviceLocator()))
    ..registerFactory(() => UserLogout(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        getUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => ChangePasswordUseCase(serviceLocator()))
    ..registerLazySingleton(
      () => ProfileBloc(changePasswordUseCase: serviceLocator()),
    );
}
