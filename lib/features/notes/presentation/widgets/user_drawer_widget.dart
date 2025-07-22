import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/usecases/logged_user_cubit.dart/logged_user_cubit.dart';
import 'package:fastnotes_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDrawerWidget extends StatelessWidget {
  const UserDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggedUserCubit, LoggedUserState>(
      builder: (context, state) {
        return Drawer(
          child: _drawerBody(state, context),
        );
      },
    );
  }

  Widget _drawerBody(LoggedUserState state, BuildContext context) {
    if (state is UserLoaded) {
      return ListView(
        children: [
          DrawerHeader(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(state.user.photoUrl),
                ),
                Text(state.user.displayName),
                Text(state.user.email),
              ],
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                context.go(RouteNames.auth);
              }
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Çıkış'),
              onTap: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
            ),
          ),
        ],
      );
    }
    if (state is UserError) {
      return Center(child: Text(state.message));
    }
    return const SizedBox.shrink();
  }
}
