import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/pages/signup_page.dart';

import '../../../../injection.dart'; 
import '../../../contact_discovery/presentation/bloc/contact_permission_bloc.dart';
import '../../../contact_discovery/presentation/widgets/contact_permission_prompt.dart';
// NEW IMPORTS FOR RETRIEVAL ENGINE TESTING
import '../../../contact_discovery/data/datasources/contact_local_data_source.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignupPage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              tooltip: 'Logout Session',
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => sl<ContactPermissionBloc>(),
          child: ContactPermissionPrompt(
            childOnGranted: _buildDashboardContent(),
          ),
        ),
      ),
    );
  }

  // Uses a FutureBuilder to asynchronously fetch and output the sanitized device list
  Widget _buildDashboardContent() {
    return FutureBuilder<List<String>>(
      future: sl<ContactLocalDataSource>().getSanitizedPhoneNumbers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Extracting & Sanitizing Device Contacts...', style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Extraction Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        final sanitizedNumbers = snapshot.data ?? [];

        // PRINT VERIFICATION DIRECTLY TO YOUR RUNNING CONSOLE TERMINAL
        debugPrint('=====================================================');
        debugPrint('🚀 SUCCESS: EXTRACTED ${sanitizedNumbers.length} UNIQUE CONTACTS');
        for (var i = 0; i < sanitizedNumbers.length; i++) {
          debugPrint('   [$i] -> Raw conversion output: ${sanitizedNumbers[i]}');
        }
        debugPrint('=====================================================');

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user_rounded, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Sync & Normalization Engine Verified!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Found ${sanitizedNumbers.length} de-duplicated numbers on this device.',
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Check your IDE terminal to see the clean mapped international strings output!',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}