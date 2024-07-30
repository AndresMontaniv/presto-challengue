import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestochallengue/data/data.dart';
import './presentation/presentation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => SearchBloc(
            MerchantsRepositoryImpl(
              datasource: MerchantsDatasourceImpl(
                baseUrl: 'mobile-backend-challengue-service.onrender.com',
                apiUrl: 'https://mobile-backend-challengue-service.onrender.com/challengue',
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Presto Test Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        ),
        home: const SearchScreen(),
      ),
    );
  }
}
