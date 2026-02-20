
import 'package:fpdart/fpdart.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';
import 'package:myblog/features/profile/domain/repository/profile_repository.dart';

class FetchUserBlogs implements UseCase<List<Blog>, NoParams> {
  final ProfileRepository profileRepository;
  FetchUserBlogs(this.profileRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await profileRepository.fetchBlogsByUser();
  }
}
