

// final getIt = GetIt.instance;

// Future<void> setupGetIt() async {
//   Dio dio = DioFactory.getDio();
//   getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

//   getIt.registerLazySingleton<StripeSevices>(() => StripeSevices(getIt()));
//   getIt.registerLazySingleton<PaymentServicesRepo>(
//       () => PaymentServicesRepo(getIt()));

//   getIt.registerFactory<MakePaymentCubit>(() => MakePaymentCubit(getIt()));
// }
