def read_input():
    items = []
    with open('input.txt') as f:
        for line in f:
            items.append(line.strip())

    return items


def get_sums(inputs):
    l = len(inputs[0])
    sums = [0 for i in range(l)]
    for ipt in inputs:
        for i, c in enumerate(ipt):
            sums[i] += int(c)

    return sums, l


def get_sums_v2(inputs):
    l = len(inputs[0])
    sums = [[] for i in range(l)]
    for ipt in inputs:
        for i, c in enumerate(ipt):
            sums[i].append(int(c))

    return sums


def get_rates(sums, l):
    gamma_rate = ['0' for i in range(l)]
    epsilon_rate = ['0' for i in range(l)]
    input_length = len(inputs)
    mid = input_length // 2
    for i, s in enumerate(sums):
        if s > mid:
            gamma_rate[i] = '1'
            epsilon_rate[i] = '0'
        else:
            gamma_rate[i] = '0'
            epsilon_rate[i] = '1'


    return int(''.join(gamma_rate), 2), int(''.join(epsilon_rate), 2)


def get_oxygen_generator_rating(inputs):
    c_inputs = inputs[:]
    i = 0
    while len(c_inputs) > 1:
        input_length = len(c_inputs)
        mid = round(input_length / 2)
        sums = get_sums_v2(c_inputs)
        if sums[i].count(1) >= sums[i].count(0):
            c_inputs = [ci for ci in c_inputs if ci[i] == '1']
        else:
            c_inputs = [ci for ci in c_inputs if ci[i] == '0']

        i += 1

    return c_inputs



def get_co2_scrubber_rating(inputs):
    c_inputs = inputs[:]
    i = 0
    while len(c_inputs) > 1:
        input_length = len(c_inputs)
        mid = round(input_length / 2)
        sums = get_sums_v2(c_inputs)
        if sums[i].count(1) >= sums[i].count(0):
            c_inputs = [ci for ci in c_inputs if ci[i] == '0']
        else:
            c_inputs = [ci for ci in c_inputs if ci[i] == '1']

        i += 1

    return c_inputs


def convert_to_int(rating):
    return int(''.join(rating), 2)


if __name__ == '__main__':
    inputs = read_input()
    sums, l = get_sums(inputs)
    gamma_rate, epsilon_rate = get_rates(sums, l)
    print(gamma_rate, epsilon_rate, gamma_rate * epsilon_rate)

    oxygen_generator_rating = convert_to_int(get_oxygen_generator_rating(inputs)[0])
    co2_scrubber_rating = convert_to_int(get_co2_scrubber_rating(inputs)[0])
    print(oxygen_generator_rating * co2_scrubber_rating)
