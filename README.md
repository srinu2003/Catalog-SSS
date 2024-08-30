# Catalog Coding Round
 
## Problem Statement
You are given a json file containing keys and points. Your task is to write a program that reads the json file, extracts the keys and points, and perform Shamir's Secret-Sharing Scheme interpolating the points to find the value of the constant term of the polynomial(which is the secret key).

### Input
The input is a json file in the following format:

```json
{
    "keys": {
        "n": <number of points> ,
        "k": <degree of the polynomial>
    },
    "<x1>": {
        "base": "<base of the value>",
        "value": "<value>"
    },
    "<x2>": {
        "base": "<base of the value>",
        "value": "<value>"
    },
    ...
}
```

- `<number of points>` (integer): The number of points provided.
- `<degree of the polynomial>` (integer): The degree of the polynomial to be interpolated.
- `<x1>`, `<x2>`, ... (string): The x values of the points.
- `<base of the value>` (string): The base of the value of the point.
- `<value>` (string): The value of the point in the specified base.

### Output
The program should output the value of the polynomial that interpolates the points at a given x value.

### Example
Input:
```json
{
    "keys": {
        "n": 4,
        "k": 3
    },
    "1": {
        "base": "10",
        "value": "4"
    },
    "2": {
        "base": "2",
        "value": "111"
    },
    "3": {
        "base": "10",
        "value": "12"
    },
    "6": {
        "base": "4",
        "value": "213"
    }
}
```

Output:
```
Key: 2.9999999999999982
```
```
n: 4, k: 3
[
    Point(x: 1, y: 4),
    Point(x: 2, y: 7),
    Point(x: 3, y: 12),
    Point(x: 6, y: 39),
]
Key: 2.9999999999999982
```

### Constraints
- The number of points (`n`) will be at least 2.
- The degree of the polynomial (`k`) will be at least 1.
- The base of the value will be a positive integer.
- The x values will be unique.
- $n >= k + 1$

## Solution
>[Shamir's Secret-Sharing Scheme](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) is a form of secret sharing, where a secret is divided into parts, giving each participant its own unique part. To reconstruct the secret, a minimum number of parts is required. In this case, the secret is the constant term of the polynomial.

The value of the polynomial at a given x value can be calculated using the formula:

```math
f(x) = a_k \cdot x^k + a_{k-1} \cdot x^{k-1} + ... + a_1 \cdot x + a_0
``` 
where $a_{0}$ is the constant term of the polynomial. In our case it's the Secret Key.

The points can be represented as $(x_0, y_0), (x_1, y_1), ..., (x_{n-1}, y_{n-1})$.

The polynomial can be interpolated using the Lagrange Interpolation Formula:

```math
f(x) = \sum_{i=0}^{k} y_i \cdot \prod_{j=0, j \neq i}^{k} \frac{x - x_j}{x_i - x_j}
```
where $y_i$ is the value of the point at $x_i$.

The Secret Key can be calculated by interpolating the points and finding the value of the polynomial at $x = 0$.

```math
a_0 = f(0) = \sum_{i=0}^{k} y_i \cdot \prod_{j=0, j \neq i}^{k} \frac{0 - x_j}{x_i - x_j}
```

The program then prints the value of the constant term $a_0$ of the polynomial, which is the Secret Key.

The time complexity of the program is $O(n^2)$, where $n$ is the number of points.