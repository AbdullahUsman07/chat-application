import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_permission_bloc.dart';
import '../bloc/contact_permission_event.dart';
import '../bloc/contact_permission_state.dart';

class ContactPermissionPrompt extends StatelessWidget {
  final Widget childOnGranted;

  const ContactPermissionPrompt({Key? key, required this.childOnGranted})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactPermissionBloc, ContactPermissionState>(
      listener: (context, state) {
        if (state is ContactPermissionGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact Synced Successfully!')),
          );
        }
      },
      builder: (context, state) {
        if (state is ContactPermissionInital) {
          context.read<ContactPermissionBloc>().add(CheckContactPermission());
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ContactPermissionChecking) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is ContactPermissionGranted) {
          return childOnGranted;
        }

        final isPermanentlyDenied = state is ContactPermissionPermanentlyDenied;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.contacts_rounded,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isPermanentlyDenied
                        ? 'It looks like contact access is permanently disabled. To find your friends automatically, please open your device settings and allow contact permissions.'
                        : 'Connect with people you know! This will securely sync your address book numbers to our database to check who is already on the network.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        final bloc = context.read<ContactPermissionBloc>();
                        if (isPermanentlyDenied) {
                          bloc.add(OpenAppSettingsEvent());
                        } else {
                          bloc.add(RequestContactPermission());
                        }
                      },
                      child: Text(
                        isPermanentlyDenied
                            ? 'Open System Settings'
                            : 'Sync My Contacts',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (!isPermanentlyDenied) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        // Handled if they choose to skip discovery for now
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Skipped contact discovery.'),
                          ),
                        );
                      },
                      child: const Text('Not Now'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
