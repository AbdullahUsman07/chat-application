import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/pages/signup_page.dart';

import '../../../../injection.dart'; 
import '../../../contact_discovery/presentation/bloc/contact_permission_bloc.dart';
import '../../../contact_discovery/presentation/widgets/contact_permission_prompt.dart';
import '../../../contact_discovery/presentation/bloc/discovery_bloc.dart';
import '../../../contact_discovery/presentation/bloc/discovery_event.dart';
import '../../../contact_discovery/presentation/bloc/discovery_state.dart';
import '../../../contact_discovery/presentation/bloc/search_bloc.dart';
import '../../../contact_discovery/presentation/bloc/search_event.dart';
import '../../../contact_discovery/presentation/bloc/search_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ContactPermissionBloc>()),
        BlocProvider(create: (context) => sl<DiscoveryBloc>()..add(SyncContactEvent())),
        BlocProvider(create: (context) => sl<SearchBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
              (route) => false,
            );
          }
        },
        child: DefaultTabController(
          length: 2, // 2 Navigation Branches: WhatsApp Sync vs Telegram Handle Search
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
              bottom: const TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(icon: Icon(Icons.contacts_rounded), text: 'My Contacts'),
                  Tab(icon: Icon(Icons.search_rounded), text: 'Global Search'),
                ],
              ),
            ),
            body: ContactPermissionPrompt(
              childOnGranted: const TabBarView(
                children: [
                  _MyContactsView(),
                  _GlobalSearchView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// === TAB 1: LOCAL CONTACT MATRIX VIEW ===
class _MyContactsView extends StatelessWidget {
  const _MyContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DiscoveryBloc>().add(SyncContactEvent());
      },
      child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
        builder: (context, state) {
          if (state is DiscoveryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DiscoveryFailure) {
            return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red)));
          }
          if (state is DiscoverySuccess) {
            final contacts = state.matchedUsers;
            if (contacts.isEmpty) {
              return const Center(child: Text('No matched phone book entries found.'));
            }
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(c.username[0].toUpperCase())),
                  title: Text(c.username),
                  subtitle: Text(c.phoneNumber ?? ''),
                  trailing: const Icon(Icons.chat, color: Colors.blue),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// === TAB 2: TELEGRAM STYLE GLOBAL DEBOUNCED SEARCH ===
class _GlobalSearchView extends StatelessWidget {
  const _GlobalSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Dynamic Search Input field
          TextField(
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchQueryChanged(value));
            },
            decoration: InputDecoration(
              hintText: 'Search unique username handles...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(
                    child: Text(
                      'Type at least 2 characters to trigger discovery...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SearchFailure) {
                  return Center(
                    child: Text(
                      'Search failed: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                }
                if (state is SearchSuccess) {
                  final users = state.results;
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('No users match your criteria.', style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final u = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.1),
                          child: Text(
                            u.username[0].toUpperCase(),
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text('@${u.username}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(u.phoneNumber ?? 'No public phone listed'),
                        trailing: const Icon(Icons.add_circle_outline, color: Colors.green),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}