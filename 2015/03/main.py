def generate_grid(l=1000):
    return [[0] * l for i in range(l)]


if __name__ == "__main__":
    input_file = "input.txt"
    grid = generate_grid()
    visited = set()
    visited.add((0, 0))
    instructions = []
    with open(input_file) as f:
        line = f.readline()
        line = line.strip()
        instructions = list(line)

    santa_x, santa_y = (0, 0)
    robo_x, robo_y = (0, 0)
    i = 0
    for instruction in instructions:
        if instruction == ">":
            if i % 2 == 0:
                santa_x += 1
            else:
                robo_x += 1
        elif instruction == "<":
            if i % 2 == 0:
                santa_x -= 1
            else:
                robo_x -= 1
        elif instruction == "^":
            if i % 2 == 0:
                santa_y -= 1
            else:
                robo_y -= 1
        else:
            if i % 2 == 0:
                santa_y += 1
            else:
                robo_y += 1
        i += 1
        visited.add((santa_x, santa_y))
        visited.add((robo_x, robo_y))

    total = len(visited)

    print(total)
