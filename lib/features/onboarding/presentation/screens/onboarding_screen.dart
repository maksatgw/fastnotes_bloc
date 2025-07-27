import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastnotes_bloc/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fastnotes_bloc/features/onboarding/presentation/widgets/onboarding_first_widget.dart';
import 'package:fastnotes_bloc/features/onboarding/presentation/widgets/onboarding_second_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  int _currentPage = 0;
  final List<Widget> _pages = [
    OnboardingFirstWidget(),
    OnboardingSecondWidget(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<OnboardingCubit>().setOnboardingFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingFinished) {
            context.read<OnboardingCubit>().checkAuth();
          }
          if (state is OnboardingAuthenticated) {
            context.go(RouteNames.notesList);
          }
          if (state is OnboardingUnauthenticated) {
            context.go(RouteNames.auth);
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            _currentPage = index;
            context.read<OnboardingCubit>().onLastPage(
              index,
              _pages.length,
            );
          },
          children: _pages,
        ),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Container(
      alignment: Alignment(0, 0.85),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              _onBackPressed();
            },
            child: Text("Back"),
          ),
          _buildPageIndicator(),
          BlocSelector<OnboardingCubit, OnboardingState, bool>(
            selector: (state) {
              return state is OnboardingLastPage ? true : false;
            },
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  _onNextPressed();
                },
                child: state ? Text("Finish") : Text("Next"),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: _controller,
      count: _pages.length,
      effect: const ExpandingDotsEffect(
        dotWidth: 10,
        dotHeight: 10,
        dotColor: Colors.grey,
        activeDotColor: Colors.blue,
      ),
    );
  }
}
