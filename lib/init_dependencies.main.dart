import 'package:branc_epl/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:branc_epl/core/network/connection_checker.dart';
import 'package:branc_epl/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:branc_epl/feature/auth/data/repositories/auth_repositories_impl.dart';
import 'package:branc_epl/feature/auth/domain/repository/auth_repository.dart';
import 'package:branc_epl/feature/auth/domain/usecases/current_user.dart';
import 'package:branc_epl/feature/auth/domain/usecases/user_login.dart';
import 'package:branc_epl/feature/auth/domain/usecases/user_logout.dart';
import 'package:branc_epl/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:branc_epl/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:branc_epl/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initAuth();
  _initLanding();
  // final supabase = await Supabase.initialize(
  //   url: AppSecrets.supabaseUrl,
  //   anonKey: AppSecrets.supabaseAnonKey,
  // );
  // Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  // serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  serviceLocator.registerFactory(() => InternetConnectionChecker());
  // // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  // DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // UserCases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerFactory(() => UserLogout(serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        userLogout: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initLanding() {
  // Datasource
  serviceLocator.registerFactory<NavigationBloc>(() => NavigationBloc());
  //   ..registerFactory<BlogRemoteDataSource>(
  //     () => BlogRemoteDataSourceImpl(
  //       serviceLocator(),
  //     ),
  //   )
  // ..registerFactory<BlogLocalDataSource>(
  //   () => BlogLocalDataSourceImpl(
  //     serviceLocator(),
  //   ),
  // )
  // Repository
  // ..registerFactory<BlogRepository>(
  //   () => BlogRepositoryImpl(
  //     serviceLocator(),
  //     serviceLocator(),
  //   ),
  // )
  // // Usecase
  // ..registerFactory(
  //   () => UploadBlog(
  //     serviceLocator(),
  //   ),
  // )
  // ..registerFactory(
  //   () => GetAllBlogs(
  //     serviceLocator(),
  //   ),
  // )
  // //
  // ..registerLazySingleton(
  //   () => BlogBloc(
  //     uploadBlog: serviceLocator(),
  //     getAllBlogs: serviceLocator(),
  //   ),
  // );
}
