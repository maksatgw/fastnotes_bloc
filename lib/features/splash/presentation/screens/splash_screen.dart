import 'package:fastnotes_bloc/core/config/constants/asset_constants.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    AppRouter.routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<SplashCubit>().startSplash();
  }

  @override
  void didPush() {
    super.didPush();
    context.read<SplashCubit>().startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          context.go(RouteNames.notesList);
        }
        if (state is SplashUnauthenticated) {
          context.go(RouteNames.auth);
        }
        if (state is SplashError) {
          context.go(RouteNames.auth);
        }
      },
      child: Scaffold(
        body: Center(
          child: Lottie.asset(AssetConstants.splashAnimation),
        ),
      ),
    );
  }
}
