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

Future<void> main() async {
  String jsonData = await File('testcase1.json').readAsString();
  Map<String, dynamic> data = jsonDecode(jsonData);
  List<Point<int>> points = formPairs(data);

  int n = data["keys"]["n"];
  int k = data["keys"]["k"];
  print("n: $n, k: $k");

  print(points);
  print(points.runtimeType);

  if (n < k) {
    print("Error: Not enough points provided.");
    return;
  }

  // Get the coefficients of the polynomial
  List<double> coefficients = lagrangeInterpolation(points, k);

  // Print the polynomial coefficients of x power 0
  print("Key: ${coefficients[0]}");
}

// Function to calculate Lagrange polynomial coefficients
List<double> lagrangeInterpolation(List<Point<int>> points, int k) {
  int n = k + 1;
  List<double> coefficients = List.filled(n, 0.0);

  for (int i = 0; i < n; i++) {
    double y_i = points[i].y.toDouble();
    List<double> basisPolynomial = List.filled(n, 0.0);
    basisPolynomial[0] = 1.0;

    for (int j = 0; j < n; j++) {
      if (i != j) {
        double x_j = points[j].x.toDouble();
        double x_i = points[i].x.toDouble();

        for (int k = n - 1; k >= 0; k--) {
          basisPolynomial[k] *= -x_j;
          if (k > 0) {
            basisPolynomial[k] += basisPolynomial[k - 1];
          }
        }

        double denom = x_i - x_j;
        for (int k = 0; k < n; k++) {
          basisPolynomial[k] /= denom;
        }
      }
    }

    for (int j = 0; j < n; j++) {
      coefficients[j] += y_i * basisPolynomial[j];
    }
  }

  return coefficients;
}
