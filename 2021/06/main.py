def process_input():
    with open('input.txt') as f:
        numbers = []
        for line in f:
            numbers.extend(line.split(','))

    return [int(number) for number in numbers]


class LanternFish:
    def __init__(self, days: int = 8):
        self.days = days

    def tick(self):
        self.days -= 1

        if self.days < 0:
            self.days = 6
            return LanternFish()

    def __str__(self):
        return str(self.days)

    def __repr__(self):
        return str(self)




if __name__ == '__main__':
    # This is my initial solution, but
    # it's not good enough for part 2! See main_v2.py
    initial_state = [3,4,3,1,2]
    fishes = [LanternFish(days=day) for day in initial_state]
    for i in range(256):
        new_fishes = []
        for fish in fishes:
            result = fish.tick()
            if result:
                new_fishes.append(result)
        fishes.extend(new_fishes)

    print(len(fishes))
