from types import NotImplementedType


class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.p = 0

    def add_point(self):
        self.p += 1

    def __str__(self) -> str:
        return f'({self.x}, {self.y}, {self.p})'

    def __repr__(self) -> str:
        return str(self)


class Line:
    def __init__(self, point1, point2):
        self.p1 = point1
        self.p2 = point2
        self._set_slope()
        self._set_minimums()

    def is_vertical(self):
        return self.p1.x == self.p2.x

    def is_horizontal(self):
        return self.p1.y == self.p2.y

    def is_45_degree_slope(self):
        if self.slope:
            return self.slope == 1 or self.slope == -1
        return False

    def _set_slope(self):
        numerator = self.p1.y - self.p2.y
        denominator = self.p1.x - self.p2.x
        if denominator == 0:
            self.slope = None
            return

        self.slope =  numerator/denominator

    def _set_minimums(self):
        self.min_x = min(self.p1.x, self.p2.x)
        self.max_x = max(self.p1.x, self.p2.x)
        self.min_y = min(self.p1.y, self.p2.y)
        self.max_y = max(self.p1.y, self.p2.y)


    def __str__(self) -> str:
        return f'{self.p1} -> {self.p2}'


def create_number_grid(max_val):
    points = []
    for i in range(0, max_val):
        row = []
        for j in range(0, max_val):
            row.append(Point(j, i))
        points.append(row)
    return points


def process_input():
    lines = []
    with open('input.txt') as f:
        for line in f:
            a, b = line.split('->')
            p1 = Point(*[int(x) for x in a.split(',')])
            p2 = Point(*[int(x) for x in b.split(',')])
            line = Line(p1, p2)
            lines.append(line)

    return lines

if __name__ == '__main__':
    points = create_number_grid(1000)
    lines = process_input()
    for line in lines:
        # Part 1
        if line.is_vertical() or line.is_horizontal():
            for y in range(line.min_y, line.max_y+1):
                for x in range(line.min_x, line.max_x+1):
                    points[y][x].add_point()

        # Part 2
        if line.is_45_degree_slope():
            x = line.p1.x
            y = line.p1.y
            end_x = line.p2.x
            end_y = line.p2.y
            if end_x < x:
                x, end_x = end_x, x
                y, end_y = end_y, y

            if line.slope == -1:
                while x <= end_x and y >= end_y:
                    points[y][x].add_point()
                    x += 1
                    y -= 1
            else:
                while x <= end_x and y <= end_y:
                    points[y][x].add_point()
                    x += 1
                    y += 1


    count = 0
    for row in points:
        for point in row:
            if point.p >= 2:
                count += 1

    print(count)
