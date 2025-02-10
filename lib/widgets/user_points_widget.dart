import 'package:checkers_mobile_client/providers/starknet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkers_mobile_client/dialog/auth_dialog.dart';
import 'package:checkers_mobile_client/widgets/ui_widgets.dart';

import 'gradient_separator.dart';

class UserPointsWidget extends ConsumerStatefulWidget {
  const UserPointsWidget({super.key});

  @override
  ConsumerState<UserPointsWidget> createState() => _UserPointsWidgetState();
}

class _UserPointsWidgetState extends ConsumerState<UserPointsWidget> {
  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    final starknet = ref.watch(starknetProvider);
    return GestureDetector(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(
              'assets/images/avatar.png',
            ), // Add your avatar image in assets folder
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                starknet.signerAccount == null
                    ? "No Account"
                    : "0x...${starknet.signerAccount!.accountAddress.toHexString().split("0x").last}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Orbitron',
                ),
              ),
              starknet.signerAccount == null
                  ? Container()
                  : Row(
                      children: [
                        SizedBox(
                          width: 12,
                          child: Image.asset('assets/images/member.png'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'XXX Pts.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          horizontalSpace(8.0),
          starknet.signerAccount == null
              ? Container()
              : const GradientSeparator(),
        ],
      ),
    );
  }
}
