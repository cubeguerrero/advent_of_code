import math

def process_input():
    with open('input.txt') as f:
        for line in f:
            numbers = [int(x) for x in line.split(',')]

    return numbers


def calculate_smallest_fuel(input):
    largest = max(input)
    smallest = min(input)
    smallest_fuel = math.inf

    for move in range(smallest, largest+1):
        total = 0
        for i in input:
            total += abs(i - move)

        print(move, total)
        if total < smallest_fuel:
            smallest_fuel = total

    return smallest_fuel


def calculate_smallest_fuel_v2(input):
    largest = max(input)
    smallest = min(input)
    smallest_fuel = math.inf

    for move in range(smallest, largest+1):
        total = 0
        for i in input:
            total_inner = abs(i - move)
            for j in range(1, total_inner+1):
                total += j

        if total < smallest_fuel:
            print(move)
            smallest_fuel = total

    return smallest_fuel


if __name__ == '__main__':
    inpt = process_input()

    print(calculate_smallest_fuel(inpt))
    print(calculate_smallest_fuel_v2(inpt))
