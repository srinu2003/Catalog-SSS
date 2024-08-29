from dataclasses import dataclass
import json
from typing import List

testcase = 'testcase2.json'

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
        term = points[i].y
        for j in range(n):
            if i != j:
                term *= (x - points[j].x) / (points[i].x - points[j].x)
        result += term

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
