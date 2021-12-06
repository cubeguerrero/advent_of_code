def process_input():

    with open('input.txt') as f:
        numbers = []
        for line in f:
            numbers.extend(line.split(','))

    return [int(number) for number in numbers]


def growth_tracker(initial_state, number_of_ticks):
    state = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
    }

    for i in initial_state:
        state[i] += 1

    for _ in range(number_of_ticks):
        print(state.values())
        next_state = {
            0: 0,
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
            7: 0,
            8: 0,
        }
        for k in range(8, -1, -1):
            v = state[k]
            next_k = k - 1
            if next_k < 0:
                next_state[6] += v
                next_state[8] += v
            else:
                next_state[next_k] = v

        state = next_state

    print(sum(state.values()))


if __name__ == '__main__':
    initial_state = process_input()
    number_of_ticks = 256
    growth_tracker(initial_state, number_of_ticks)
