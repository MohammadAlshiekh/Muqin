import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/providers/provider.dart';

class MyDrawerHeader extends ConsumerWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
        final user = ref.watch(userProvider);
    return   UserAccountsDrawerHeader(
      accountName: Text("${user?.displayName}"),
      accountEmail: Text("${user?.email}"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: user?.photoURL != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  user!.photoURL!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.person,
                size: 50,
                color: Colors.black,
              )
      ),
    );
  }
}