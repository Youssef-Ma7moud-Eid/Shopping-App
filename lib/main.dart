import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopping_app/core/bloc_observer/bloc_observer.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper.dart';
import 'package:shopping_app/core/utils/local_notification_services.dart';
import 'package:shopping_app/feature/app_section/app_section.dart';
import 'package:shopping_app/feature/auth/presentation/views/login_screen.dart';
import 'package:shopping_app/feature/auth/presentation/views/register_screen.dart';
import 'package:shopping_app/feature/cart/presentation/manager/add-card-cubit/add_cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/domain/usecase/get_category_usecase.dart';
import 'package:shopping_app/feature/home/domain/usecase/get_product_by_catagory_usecase.dart';
import 'package:shopping_app/feature/home/domain/usecase/get_products_usecase.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-catergory-cubit/get_catergory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-product-by-catagory/get_product_by_catgory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-products-cubit/get_products_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/prouct_of_category_view.dart';
import 'package:shopping_app/feature/onboarding/presentation/views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  // Local notifications
  await LoalNotificationServices.initialize();
  await LoalNotificationServices.requestPermission();

  // Battery optimization (Android only)
  if (Platform.isAndroid) {
    await Permission.ignoreBatteryOptimizations.request();
  }
  runApp(const MyApp());
  Bloc.observer = AppBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static List<GetProductEntity> listFavorite = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetProductByCatgoryCubit(injectableGetProductByCatagoryUsecase()),
        ),
        BlocProvider(
          create: (context) =>
              GetCatergoryCubit(injectableGetCategoryUsecase())
                ..getCategories(),
        ),
        BlocProvider(
          create: (context) =>
              GetProductsCubit(injectableGetProductsUsecase())..getProducts(),
        ),
        BlocProvider(create: (context) => AddCartCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "User App",
        initialRoute: getView(),
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          AppSection.routeName: (context) => const AppSection(),
          ProuctOfCategoryView.routeName: (context) =>
              const ProuctOfCategoryView(id: 1),
        },
      ),
    );
  }
}

getView() {
  bool isNew = CacheHelper().getData(key: 'NewUser') ?? false;
  bool isLogin = CacheHelper().getData(key: 'Login') ?? false;
  if (isNew && isLogin) {
    return AppSection.routeName;
  } else if (isNew) {
    return LoginScreen.routeName;
  } else {
    return OnboardingScreen.routeName;
  }
}
