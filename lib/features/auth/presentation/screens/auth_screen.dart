import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:fastnotes_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackbarFactoryUtil.buildInfoSnackBar(
                  'Loading...',
                ),
              );
            }
            if (state is AuthSuccess) {
              GlobalSnackBarUtil.showSuccessSnackbar(
                'Login successful',
              );
              context.go(RouteNames.notesList);
            }
            if (state is AuthLoggedOut) {
              context.go(RouteNames.auth);
            }
            if (state is AuthError) {
              GlobalSnackBarUtil.showErrorSnackbar(
                'Login failed, please try again',
              );
            }
          },
          builder: (context, state) {
            return state is AuthLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () => context.read<AuthBloc>().add(LoginEvent()),
                    child: const Text('Login with Google'),
                  );
          },
        ),
      ),
    );
  }
}
