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
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            context.go(RouteNames.notesList);
          }
        },
        child: Scaffold(
          body: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              return state is SplashAnimating
                  ? Center(
                      child: Lottie.asset(
                        'assets/lotties/splash_animation.json',
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
