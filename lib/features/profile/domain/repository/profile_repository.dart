import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Either<Failure, List<Blog>>> fetchBlogsByUser();
}
