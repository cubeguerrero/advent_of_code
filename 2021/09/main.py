from functools import reduce

class Point:
    def __init__(self, val):
        self.val = val
        self.is_lowest = False

    def __eq__(self, other):
        return self.val == other.val

    def __lt__(self, other):
        return self.val < other.val

    def __gt__(self, other):
        return self.val > other.val

    def __ge__(self, other):
        return self.val >= other.val

    def __le__(self, other):
        return self.val <= other.val

    def __str__(self):
        return str(self.val)

    def __repr__(self):
        return str(self)


def process_input():
    points = []
    with open('input.txt') as f:
        for line in f:
            line = line.strip()
            row = []
            for c in line:
                row.append(Point(int(c)))

            points.append(row)

    return points


def get_lowest_points(data):
    min_r = 0
    max_r = len(data) - 1
    lowest_points = []
    for row, line in enumerate(data):
        min_c = 0
        max_c = len(line) - 1
        for col, point in enumerate(line):
            top_r = row - 1
            bottom_r = row + 1
            left_c = col - 1
            right_c = col + 1
            need_to_cmp = []
            if top_r >= min_r:
                need_to_cmp.append(data[top_r][col])

            if bottom_r <= max_r:
                need_to_cmp.append(data[bottom_r][col])

            if left_c >= min_c:
                need_to_cmp.append(data[row][left_c])

            if right_c <= max_c:
                need_to_cmp.append(data[row][right_c])

            if all([point < p for p in need_to_cmp]):
                point.is_lowest = True
                lowest_points.append((row, col))

    return lowest_points


def find_basin(data, row, col, visited=[]):
    if row < 0:
        return []

    if row >= len(data):
        return []

    if col < 0:
        return []

    if col >= len(data[0]):
        return []

    if (row, col) in visited:
        return []

    if data[row][col].val == 9:
        return []

    basin = []
    basin.append(data[row][col])
    visited.append((row, col))
    basin.extend(find_basin(data, row-1, col, visited))
    basin.extend(find_basin(data, row+1, col, visited))
    basin.extend(find_basin(data, row, col-1, visited))
    basin.extend(find_basin(data, row, col+1, visited))
    return basin



if __name__ == '__main__':
    data = process_input()
    lowest_points = get_lowest_points(data)
    basins = []
    for row, col in lowest_points:
        basin = find_basin(data,row, col)
        basins.append(basin)

    basin_lengths = sorted([len(basin) for basin in basins])[::-1]
    print(reduce(lambda x, y: x * y, basin_lengths[:3]))
