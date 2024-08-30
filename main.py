from dataclasses import dataclass
import json
from typing import List

testcase = 'testcase1.json'

@dataclass
class Point:
    x: int
    y: int

    def __str__(self):
        return f'({self.x}, {self.y})'

def legranges_interpolation_polynomial(points: List[Point], k: int, x: int) -> float:
    '''
    Given a set of points, this function returns the value of the polynomial
    that interpolates the points at the given x value.
    '''
    n = k + 1
    result = 0.0

    for i in range(n):
        x_i, y_i = points[i].x, points[i].y
        # print(f'At x_i = {points[i].x}, y_i = {points[i].y}')
        lagrange_basis = 1.0
        for j in range(n):
            if i != j:
                lagrange_basis *= (0.0 - points[j].x) / (x_i - points[j].x)
        # print(f'  L_i({x_i}) = {lagrange_basis}, P_i({x_i}) = {y_i * lagrange_basis}')
        result += y_i * lagrange_basis

    return result

if __name__ == '__main__':
    with open(testcase, 'r') as file:
        data = json.load(file)

    points = []
    for k, v in data.items():
        if k != 'keys':
            x, y = int(k), int(v['value'], base=int(v['base']))
            point = Point(x, y)
            points.append(point)
    print(points)

    n, k = int(data['keys']['n']), int(data['keys']['k'])
    print(n, k)

    coefficients: List[float] = legranges_interpolation_polynomial(points, k, 0)

    print(coefficients)
