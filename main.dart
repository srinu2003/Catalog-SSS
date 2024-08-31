import 'dart:convert';
import 'dart:io';
import 'dart:math';

List<Point<int>> formPairs(Map<String, dynamic> data) {
  List<Point<int>> pairs = [];

  data.forEach((key, value) {
    if (key != "keys") {
      int x = int.parse(key);
      int base = int.parse(value["base"]);
      int y = int.parse(value["value"], radix: base);

      pairs.add(Point(x, y));
    }
  });

  return pairs;
}

double lagrangeInterpolation(List<Point<int>> points, int k) {
  int n = k + 1;
  double result = 0.0;

  for (int i = 0; i < n; i++) {
    double term = points[i].y.toDouble();
    double x_i = points[i].x.toDouble();
    for (var j = 0; j < n; j++) {
      if (j != i) {
        double x_j = points[j].x.toDouble();
        term *= (0.0 - x_j) / (x_i - x_j);
      }
    }
    result += term;
  }

  return result;
}

void main() {
  String jsonData = File('testcase1.json').readAsStringSync();
  Map<String, dynamic> data = jsonDecode(jsonData);
  List<Point<int>> points = formPairs(data);

  int n = data["keys"]["n"];
  int k = data["keys"]["k"];
  // print("n: $n, k: $k");

  // print(points);

  if (n < k) {
    print("Error: Not enough points provided.");
    return;
  }

  double constant = lagrangeInterpolation(points, k);
  print("Key: ${constant.toDouble()}");
}
