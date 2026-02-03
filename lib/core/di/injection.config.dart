// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:myprofile/core/di/register_module.dart' as _i37;
import 'package:myprofile/core/services/image_upload_service.dart' as _i398;
import 'package:myprofile/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i914;
import 'package:myprofile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i985;
import 'package:myprofile/features/auth/domain/repositories/auth_repository.dart'
    as _i164;
import 'package:myprofile/features/auth/domain/usecases/login_usecase.dart'
    as _i880;
import 'package:myprofile/features/auth/presentation/cubit/auth_cubit.dart'
    as _i569;
import 'package:myprofile/features/blog/data/datasources/blog_remote_data_source.dart'
    as _i598;
import 'package:myprofile/features/blog/data/repositories/blog_repository_impl.dart'
    as _i221;
import 'package:myprofile/features/blog/domain/repositories/blog_repository.dart'
    as _i650;
import 'package:myprofile/features/blog/domain/usecases/add_comment.dart'
    as _i452;
import 'package:myprofile/features/blog/domain/usecases/create_blog_post.dart'
    as _i506;
import 'package:myprofile/features/blog/domain/usecases/delete_blog_post.dart'
    as _i284;
import 'package:myprofile/features/blog/domain/usecases/delete_comment.dart'
    as _i578;
import 'package:myprofile/features/blog/domain/usecases/get_blog_post_by_id.dart'
    as _i466;
import 'package:myprofile/features/blog/domain/usecases/get_blog_posts.dart'
    as _i474;
import 'package:myprofile/features/blog/domain/usecases/get_comments.dart'
    as _i754;
import 'package:myprofile/features/blog/domain/usecases/like_post.dart' as _i91;
import 'package:myprofile/features/blog/domain/usecases/update_blog_post.dart'
    as _i1042;
import 'package:myprofile/features/blog/presentation/bloc/blog_bloc.dart'
    as _i618;
import 'package:myprofile/features/projects/data/datasources/project_remote_datasource.dart'
    as _i281;
import 'package:myprofile/features/projects/data/repositories/project_repository_impl.dart'
    as _i461;
import 'package:myprofile/features/projects/domain/repositories/project_repository.dart'
    as _i334;
import 'package:myprofile/features/projects/domain/usecases/add_project_usecase.dart'
    as _i193;
import 'package:myprofile/features/projects/domain/usecases/delete_project_usecase.dart'
    as _i21;
import 'package:myprofile/features/projects/domain/usecases/get_projects_usecase.dart'
    as _i779;
import 'package:myprofile/features/projects/domain/usecases/update_project_usecase.dart'
    as _i287;
import 'package:myprofile/features/projects/presentation/cubit/projects_cubit.dart'
    as _i569;
import 'package:myprofile/features/resume/domain/repositories/resume_repository.dart'
    as _i449;
import 'package:myprofile/features/resume/domain/services/resume_service.dart'
    as _i952;
import 'package:myprofile/features/resume/infrastructure/datasources/resume_remote_datasource.dart'
    as _i755;
import 'package:myprofile/features/resume/infrastructure/repositories/resume_repository_impl.dart'
    as _i748;
import 'package:myprofile/features/resume/presentation/cubit/resume_cubit.dart'
    as _i180;
import 'package:myprofile/features/social_links/domain/repositories/social_links_repository.dart'
    as _i237;
import 'package:myprofile/features/social_links/infrastructure/datasources/social_links_remote_datasource.dart'
    as _i431;
import 'package:myprofile/features/social_links/infrastructure/repositories/social_links_repository_impl.dart'
    as _i114;
import 'package:myprofile/features/social_links/presentation/cubit/social_links_cubit.dart'
    as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(() => registerModule.storage);
    gh.lazySingleton<_i952.ResumeService>(() => _i952.ResumeService());
    gh.lazySingleton<_i755.ResumeRemoteDatasource>(
      () => _i755.ResumeRemoteDatasource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i457.FirebaseStorage>(),
      ),
    );
    gh.lazySingleton<_i449.ResumeRepository>(
      () => _i748.ResumeRepositoryImpl(gh<_i755.ResumeRemoteDatasource>()),
    );
    gh.lazySingleton<_i914.AuthDataSource>(
      () => _i914.AuthDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i398.ImageUploadService>(
      () => _i398.ImageUploadService(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i164.AuthRepository>(
      () => _i985.AuthRepositoryImpl(gh<_i914.AuthDataSource>()),
    );
    gh.lazySingleton<_i598.BlogRemoteDataSource>(
      () => _i598.BlogRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i431.SocialLinksRemoteDatasource>(
      () => _i431.SocialLinksRemoteDatasource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i281.ProjectDataSource>(
      () => _i281.ProjectDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i180.ResumeCubit>(
      () => _i180.ResumeCubit(gh<_i449.ResumeRepository>()),
    );
    gh.lazySingleton<_i650.BlogRepository>(
      () => _i221.BlogRepositoryImpl(gh<_i598.BlogRemoteDataSource>()),
    );
    gh.lazySingleton<_i334.ProjectRepository>(
      () => _i461.ProjectRepositoryImpl(gh<_i281.ProjectDataSource>()),
    );
    gh.lazySingleton<_i880.LoginUseCase>(
      () => _i880.LoginUseCase(gh<_i164.AuthRepository>()),
    );
    gh.lazySingleton<_i237.SocialLinksRepository>(
      () => _i114.SocialLinksRepositoryImpl(
        gh<_i431.SocialLinksRemoteDatasource>(),
      ),
    );
    gh.factory<_i569.AuthCubit>(
      () => _i569.AuthCubit(gh<_i880.LoginUseCase>()),
    );
    gh.lazySingleton<_i452.AddCommentUseCase>(
      () => _i452.AddCommentUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i506.CreateBlogPostUseCase>(
      () => _i506.CreateBlogPostUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i284.DeleteBlogPostUseCase>(
      () => _i284.DeleteBlogPostUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i578.DeleteCommentUseCase>(
      () => _i578.DeleteCommentUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i466.GetBlogPostByIdUseCase>(
      () => _i466.GetBlogPostByIdUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i474.GetBlogPostsUseCase>(
      () => _i474.GetBlogPostsUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i754.GetCommentsUseCase>(
      () => _i754.GetCommentsUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i91.LikePostUseCase>(
      () => _i91.LikePostUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i1042.UpdateBlogPostUseCase>(
      () => _i1042.UpdateBlogPostUseCase(gh<_i650.BlogRepository>()),
    );
    gh.lazySingleton<_i193.AddProjectUseCase>(
      () => _i193.AddProjectUseCase(gh<_i334.ProjectRepository>()),
    );
    gh.lazySingleton<_i21.DeleteProjectUseCase>(
      () => _i21.DeleteProjectUseCase(gh<_i334.ProjectRepository>()),
    );
    gh.lazySingleton<_i779.GetProjectsUseCase>(
      () => _i779.GetProjectsUseCase(gh<_i334.ProjectRepository>()),
    );
    gh.lazySingleton<_i287.UpdateProjectUseCase>(
      () => _i287.UpdateProjectUseCase(gh<_i334.ProjectRepository>()),
    );
    gh.factory<_i809.SocialLinksCubit>(
      () => _i809.SocialLinksCubit(gh<_i237.SocialLinksRepository>()),
    );
    gh.factory<_i569.ProjectsCubit>(
      () => _i569.ProjectsCubit(
        gh<_i779.GetProjectsUseCase>(),
        gh<_i193.AddProjectUseCase>(),
        gh<_i287.UpdateProjectUseCase>(),
        gh<_i21.DeleteProjectUseCase>(),
      ),
    );
    gh.factory<_i618.BlogBloc>(
      () => _i618.BlogBloc(
        gh<_i474.GetBlogPostsUseCase>(),
        gh<_i466.GetBlogPostByIdUseCase>(),
        gh<_i754.GetCommentsUseCase>(),
        gh<_i452.AddCommentUseCase>(),
        gh<_i91.LikePostUseCase>(),
        gh<_i506.CreateBlogPostUseCase>(),
        gh<_i1042.UpdateBlogPostUseCase>(),
        gh<_i284.DeleteBlogPostUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
