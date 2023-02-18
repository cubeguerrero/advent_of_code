def solution(input: str) -> int:
    floor = 0
    pos = 0
    input = list(input)
    for i in input:
        pos += 1
        if i == "(":
            floor += 1
        elif i == ")":
            floor -= 1
        else:
            raise ValueError("Only '(' and ')' are allowed.")

        if floor < 0:
            break

    return floor, pos


if __name__ == "__main__":
    with open("./input.txt") as f:
        line = f.readline().strip()
        floor, pos = solution(line)
        print(floor, pos)
