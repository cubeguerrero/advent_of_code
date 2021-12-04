class Board:
    def __init__(self, rows):
        self.rows = rows
        self.tags = []
        self.won = False
        self.total = 0
        for r in rows:
            self.tags.append([0 for x in r])


    def __str__(self):
        return str(self.rows) + str(self.tags)


    def tag_number_in_board(self, number):
        for i, r in enumerate(self.rows):
            if number in r:
               j = r.index(number)
               self.tags[i][j] = 1

    def check_if_win(self):
        t_len = len(self.tags)
        for i in range(t_len):
            row = sum(self.tags[i])
            if row == t_len:
                self.won = True
                return True

            col = 0
            for j in range(t_len):
                col += self.tags[j][i]

            if col == t_len:
                self.won = True
                return True

        return False

    def get_sum_of_unmarked_numbers(self):
        if not self.won:
            return

        if self.total > 0:
            return self.total

        for i, t in enumerate(self.tags):
            for j, n in enumerate(t):
                if n == 0:
                    self.total += int(self.rows[i][j])

        return self.total


def process_input():
    with open('input.txt') as f:
        count = 0
        boards = []
        numbers = ''
        for line in f:
            if not line == '\n':
                if count == 0:
                   numbers = line.strip()
                else:
                    boards.append(line.split())

            count += 1

    boards = [Board(boards[i:(i+5)]) for i in range(0, len(boards), 5)]

    return numbers.split(','), boards



if __name__ == '__main__':
    # board = """14 21 17 24  4
# 10 16 15  9 19
# 18  8 23 26 20
# 22 11 13  6  5
#  2  0 12  3  7"""

#     rows = [x.split() for x in board.split("\n")]
#     b = Board(rows)

#     nums = '7,4,9,5,11,17,23,2,0,14,21,24'.split(',')
#     for n in nums:
#         b.tag_number_in_board(n)
#         if b.check_if_win():
#             print(n, b.get_sum_of_unmarked_numbers(), b)

    numbers, boards = process_input()

    # part 1
    for n in numbers:
        for b in boards:
            b.tag_number_in_board(n)
            if b.check_if_win():
                print(n, b.get_sum_of_unmarked_numbers(), int(n) * b.total)
                break
        else:
            continue
        break

    # part 2
    x = []
    for n in numbers:
        for b in boards:
            if b.won:
                continue

            b.tag_number_in_board(n)
            if b.check_if_win():
                print(n, b.get_sum_of_unmarked_numbers(), int(n) * b.total)
                x.append(b)

    print(x[-1])
