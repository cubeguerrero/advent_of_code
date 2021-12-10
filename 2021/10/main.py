CORRUPTED_POINTS = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137
}

INCOMPLETE_POINTS = {
    '(': 1,
    '[': 2,
    '{': 3,
    '<': 4
}

class Instruction:
    def __init__(self, instruction):
        self.instruction = instruction
        self.state = None # can be incomplete or corrupted
        self.first_corrupted = ''
        self.corrupted_points = 0
        self.incomplete_points = 0
        self.stack = []

    def process(self):
        self.stack = []
        for i in self.instruction:
            if i in ['(', '[', '{', '<']:
                self.stack.append(i)
            else:
                last = self.stack.pop()
                if (i == ')' and last != '(') or (i == ']' and last != '[') or (i == '}' and last != '{') or (i == '>' and last != '<'):
                    self.state = "corrupted"
                    self.first_corrupted = i
                    self.corrupted_points = CORRUPTED_POINTS[i]
                    return

        if len(self.stack) > 0:
            self.state = "incomplete"

    def fix_instruction(self):
        if self.state != 'incomplete':
            return

        while len(self.stack) > 0:
            last = self.stack.pop()
            self.incomplete_points = self.incomplete_points * 5
            self.incomplete_points += INCOMPLETE_POINTS[last]


def process_input(file_name):
    instructions = []
    with open(file_name) as f:
        for line in f:
            instructions.append(Instruction(line.strip()))

    return instructions


def process_instruction(instructions):
    corrupted_total = 0
    incomplete_total = []
    for i in instructions:
        i.process()
        if i.state == "corrupted":
            corrupted_total += i.corrupted_points
        else:
            i.fix_instruction()
            incomplete_total.append(i.incomplete_points)

    incomplete_total.sort()
    print(corrupted_total, incomplete_total[len(incomplete_total)//2])

if __name__ == '__main__':
    instructions = process_input('input.txt')
    process_instruction(instructions)
