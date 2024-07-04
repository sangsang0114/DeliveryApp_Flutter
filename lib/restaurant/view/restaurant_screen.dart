import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginationRestaurant() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final dio = Dio();
    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );
    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              future: paginationRestaurant(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final pItem = RestaurantModel.fromJson(json: item);
                    return GestureDetector(
                      child: RestaurantCard.fromModel(model: pItem),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(
                              id: pItem.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 16.0);
                  },
                  itemCount: snapshot.data!.length,
                );
              },
            )),
      ),
    );
  }
}
