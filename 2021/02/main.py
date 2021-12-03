def get_instructions():
    instructions = []
    with open('input.txt') as f:
        for line in f:
            x = line.split()
            x[1] = int(x[1])
            instruction = x
            instructions.append(instruction)

    return instructions


def get_position(instructions):
    position = [0, 0] # first is horizontal position, second is vertical positon
    for instruction, num in instructions:
        if instruction == 'forward':
            position[0] += num
        elif instruction == 'down':
            position[1] += num
        elif instruction == 'up':
            position[1] -= num

    return position


def get_position_v2(instructions):
    position = [0, 0, 0] # horizontal, depth, aim
    for instruction, num in instructions:
        if instruction == 'forward':
            position[0] += num
            increase = position[2] * num
            position[1] += increase
        elif instruction == 'down':
            position[2] += num
        elif instruction == 'up':
            position[2] -= num

    return position


if __name__ == '__main__':
    instructions = get_instructions()
    position = get_position(instructions)
    print(position)
    print(position[0] * position[1])

    position = get_position_v2(instructions)
    print(position)
    print(position[0] * position[1])
