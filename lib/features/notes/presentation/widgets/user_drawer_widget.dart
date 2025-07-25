import 'package:fastnotes_bloc/core/config/constants/asset_constants.dart';
import 'package:flutter/material.dart';

class UserDrawerWidget extends StatelessWidget {
  const UserDrawerWidget({
    super.key,
    required this.onLogout,
    this.photoUrl,
    this.displayName,
    this.email,
  });
  final VoidCallback onLogout;
  final String? photoUrl;
  final String? displayName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _buildDrawerBody(context),
    );
  }

  Widget _buildDrawerBody(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: photoUrl != null
                    ? NetworkImage(photoUrl!)
                    : AssetImage(AssetConstants.userAvatarPlaceholder),
              ),
              Text(displayName ?? ''),
              Text(email ?? ''),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text('Çıkış'),
          onTap: onLogout,
        ),
      ],
    );
  }
}
