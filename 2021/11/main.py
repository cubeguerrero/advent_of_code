def process_input(file_name):
    state = []
    with open(file_name) as f:
        for line in f:
            row = []
            for c in line.strip():
                row.append(int(c))
            state.append(row)

    return state


def print_state(state):
    print()
    for row in state:
        print(''.join([str(r) for r in row]))


def get_positions(row, col):
    positions = []

    y = row - 1
    if 0 <= y < 10:
        positions.append((y, col))

        x = col - 1
        if 0 <= x < 10:
            positions.append((y, x))

        x = col + 1
        if 0 <= x < 10:
            positions.append((y, x))

    y = row
    if 0 <= y < 10:
        x = col - 1
        if 0 <= x < 10:
            positions.append((y, x))

        x = col + 1
        if 0 <= x < 10:
            positions.append((y, x))

    y = row + 1
    if 0 <= y < 10:
        positions.append((y, col))

        x = col - 1
        if 0 <= x < 10:
            positions.append((y, x))

        x = col + 1
        if 0 <= x < 10:
            positions.append((y, x))

    return positions


def process_state(state):
    flashes = 0
    queue = []
    for row, line in enumerate(state):
        for col, octopus in enumerate(line):
            octopus += 1
            state[row][col] = octopus
            if state[row][col] > 9:
                queue.append((row, col))

    while len(queue) > 0:
        row, col = queue.pop(0)

        octopus = state[row][col]
        if octopus > 9:
            flashes += 1
            state[row][col] = 0
            positions = get_positions(row, col)
            queue.extend(positions)
        elif octopus == 0:
            next
        else:
            octopus += 1
            state[row][col] = octopus
            if state[row][col] > 9:
                queue.append((row, col))

    return flashes


def is_synchronized(state):
    total = 0
    for row in state:
        for octopus in row:
            total += octopus

    return total == 0



def run_simulation(length, state):
    flashes = 0
    for i in range(length):
        flashes += process_state(state)
        print_state(state)

    print(flashes)


def run_simulation_v2(state):
    count = 0
    while not is_synchronized(state):
        process_state(state)
        count += 1

    print(count)

if __name__ == '__main__':
    state = process_input('input.txt')
    run_simulation_v2(state)
