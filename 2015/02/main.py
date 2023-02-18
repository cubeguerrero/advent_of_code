class Rectangle:
    def __init__(self, width, length, height) -> None:
        self.width = int(width)
        self.length = int(length)
        self.height = int(height)

    def surface_area(self) -> int:
        return (
            (2 * self.width * self.length)
            + (2 * self.width * self.height)
            + (2 * self.height * self.length)
        )

    def smallest_side(self) -> int:
        return min(
            [
                self.length * self.width,
                self.width * self.height,
                self.height * self.length,
            ]
        )

    def smallest_perimeter(self) -> int:
        return min(
            [
                (2 * (self.width + self.length)),
                (2 * (self.width + self.height)),
                (2 * (self.height + self.length)),
            ]
        )

    def needed_ribbon(self) -> int:
        return self.smallest_perimeter() + (self.width * self.length * self.height)


if __name__ == "__main__":
    with open("./input.txt") as f:
        rectangles = []
        total = 0
        ribbon = 0
        for line in f:
            width, length, height = line.strip().split("x")
            rectangle = Rectangle(width, length, height)
            rectangles.append(rectangle)
            total += rectangle.surface_area() + rectangle.smallest_side()
            ribbon += rectangle.needed_ribbon()

    print(total, ribbon)
