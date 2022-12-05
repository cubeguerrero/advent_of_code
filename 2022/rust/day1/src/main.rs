use std::fs;

fn main() {
    let contents = fs::read_to_string("input.txt").expect("input.txt cannot be found.");
    let mut largest = 0;
    let mut current = 0;
    let mut calories: Vec<i32> = vec![];
    for line in contents.lines() {
        let line = line.trim();
        if line == "" {
            calories.push(current);
            if current > largest {
                largest = current;
            }
            current = 0;
        } else {
            current += line.parse::<i32>().unwrap();
        }
    }

    calories.sort();
    let three_largest =
        calories[calories.len() - 1] + calories[calories.len() - 2] + calories[calories.len() - 3];
    println!("{} - {}", largest, three_largest);
}
