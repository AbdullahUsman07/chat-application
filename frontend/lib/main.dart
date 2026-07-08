
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/pages/signup_page.dart';
import 'injection.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/chat_dashboard/presentation/pages/dashboard_page.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  final localDataStore = di.sl<AuthLocalDataSource>();
  final String? token = await localDataStore.getToken();

  runApp(ChatApp(initialToken: token,));
}

class ChatApp extends StatelessWidget {
  final String? initialToken;

  const ChatApp({Key? key, this.initialToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) {
            final authBloc = di.sl<AuthBloc>();

            if(initialToken != null){
              authBloc.emit(AuthAuthenticated(initialToken!));
            }
            return authBloc;
          }
          ),
      ],
      child: MaterialApp(
        title: 'Real-Time Chat App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: initialToken != null ? DashboardPage() : SignupPage(),
      ),
    );
  }
}