import "dart:convert";

import "package:fresk/model/association.dart";
import "package:http/http.dart" as http;

Future<List<Association>> fetchAssociations() async {
  final response =
      await http.get(Uri.parse("http://localhost:9090/associations"));

  if (response.statusCode == 200) {
    var j = (jsonDecode(response.body) as Map<String, dynamic>)["associations"];

    return (j as List<dynamic>)
        .map((json) => Association.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load associations');
  }
}
