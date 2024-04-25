import 'package:flutter/material.dart';
import 'package:prism_medico/Repo/allProductRepo.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class search extends SearchDelegate<String> {
  late List<Latest_Product_model> cart;
  late List<String> data;
  void listData() {
    allProductListRepo.getallProduct().then((value) {
      // productData = value.data;
      for (int i = 0; i < value!.data.length; i++) {
        var list = Latest_Product_model(name: value.data[i].name);
        var idlist = Latest_Product_model(id: value.data[i].id);
        print(list.name);
        print(idlist.id);
        data.add(list.name);
        // suggestions.add(idlist.id);
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<SuperResponse<List<Latest_Product_model>>?>(
        future: allProductListRepo.getallProduct(),
        builder: (BuildContext context,
            AsyncSnapshot<SuperResponse<List<Latest_Product_model>>?> snap) {
    if (snap.connectionState == ConnectionState.waiting) {
    // Return a loading indicator while waiting for data
    return CircularProgressIndicator();
    } else if (snap.hasError) {
    // Return an error message widget if an error occurs
    return Text('Error: ${snap.error}');
    } else if (!snap.hasData || snap.data == null) {
    // Return a placeholder widget if there's no data
    return Text('No data available');
    } else {
            // for (int i = 0; i < snap.data.data.length; i++) {
            //   var list = Latest_Product_model(name: snap.data.data[i].name);

            //   data.add(list.name);
            // }
            var listToShow;
            if (query.isNotEmpty)
              listToShow = data
                  .where((e) => e.contains(query) && e.startsWith(query))
                  .toList();
            else
              listToShow = data;
            return ListView.builder(
              itemCount: listToShow.length,
              itemBuilder: (_, i) {
                var noun = listToShow[i];
                return ListTile(
                  title: Text(noun),
                  onTap: () => close(context, noun),
                );
              },
            );
        }
        });
  }
}
