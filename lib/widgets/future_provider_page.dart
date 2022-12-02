import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/cat_fact_model.dart';

final httpClientProvider = Provider(((ref) {
  return Dio(BaseOptions(baseUrl: "https://catfact.ninja/"));
}));

final catFactsProvider = FutureProvider.autoDispose
    .family<List<CatFactModel>, Map<String, dynamic>>(
        ((ref, parametersMap) async {
  final dio = ref.watch(httpClientProvider);
  final result = await dio.get("facts", queryParameters: parametersMap);
  ref.keepAlive();
  List<Map<String, dynamic>> mapData = List.from(result.data["data"]);
  List<CatFactModel> catFatList =
      mapData.map((e) => CatFactModel.fromMap(e)).toList();
  return catFatList;
}));

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var liste =
        ref.watch(catFactsProvider(const {"limit": 4, "max_length": 30}));
    return Scaffold(
      body: SafeArea(
        child: liste.when(
            data: (liste) {
              return ListView.builder(
                itemCount: liste.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(liste[index].fact),
                    leading: Text(
                      liste[index].length.toString(),
                      style: const TextStyle(
                          backgroundColor: Colors.indigo,
                          color: Colors.white,
                          fontSize: 32),
                    ),
                  );
                },
              );
            },
            error: ((error, stackTrace) {
              return Center(
                child: Text("hata cıktı ${error.toString()}"),
              );
            }),
            loading: () => CircularProgressIndicator()),
      ),
    );
  }
}
