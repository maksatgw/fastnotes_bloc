import 'package:fastnotes_bloc/core/constants/asset_constants.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
        body: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return state is SplashAnimating
                ? Center(child: Lottie.asset(AssetConstants.splashAnimation))
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
