import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AuthUser>> login(String email, String password) async {
    try {
      final credential = await dataSource.login(email, password);
      final user = credential.user!;
      return Right(AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
      ));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await dataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      final user = await dataSource.getCurrentUser();
      if (user == null) return const Right(null);
      return Right(AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
      ));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
