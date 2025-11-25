// part of 'init_dependencies.dart';

// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// final serviceLocator = GetIt.instance;

import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:branc_epl/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // _initAuth();
  _initLanding();
  // final supabase = await Supabase.initialize(
  //   url: AppSecrets.supabaseUrl,
  //   anonKey: AppSecrets.supabaseAnonKey,
  // );
  // // Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // serviceLocator.registerLazySingleton(() => supabase.client);

  // serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  // serviceLocator.registerFactory(() => InternetConnectionChecker());
  // // core
  // serviceLocator.registerLazySingleton(() => AppUserCubit());

  // serviceLocator.registerFactory<ConnectionChecker>(
  //   () => ConnectionCheckerImpl(serviceLocator()),
  // );
}

// void _initAuth() {
//   // DataSource
//   serviceLocator
//     ..registerFactory<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(serviceLocator()),
//     )
//     // Repository
//     ..registerFactory<AuthRepository>(
//       () => AuthRepositoryImpl(
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     )
//     // UserCases
//     ..registerFactory(
//       () => UserSignUp(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => UserLogin(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => CurrentUser(
//         serviceLocator(),
//       ),
//     )
// // Bloc
//     ..registerLazySingleton(
//       () => AuthBloc(
//         userSignUp: serviceLocator(),
//         userLogin: serviceLocator(),
//         currentUser: serviceLocator(),
//         appUserCubit: serviceLocator(),
//       ),
//     );
// }

void _initLanding() {
  // Datasource
  serviceLocator..registerFactory<NavigationBloc>(() => NavigationBloc());
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
