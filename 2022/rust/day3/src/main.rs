use std::collections::HashSet;
use std::fs;

fn string_to_set(s: &str) -> HashSet<char> {
    let mut set = HashSet::new();
    for s in s.chars() {
        set.insert(s);
    }
    set
}

fn get_score(c: char) -> usize {
    let mut alphabet: Vec<char> = ('a'..='z').collect();
    let mut capital_letters: Vec<char> = ('A'..='Z').collect();
    alphabet.append(&mut capital_letters);
    alphabet.iter().position(|&x| x == c).unwrap() + 1
}

fn part1(line: &str) -> usize {
    let mid = line.len() / 2;
    let set1 = string_to_set(&line[0..mid]);
    let set2 = string_to_set(&line[mid..(line.len())]);
    let intersection: Vec<&char> = set1.intersection(&set2).collect();
    let letter = intersection[0];
    get_score(*letter)
}

fn main() {
    let mut total = 0;
    let contents = fs::read_to_string("input.txt").expect("Failed to read input file");
    for line in contents.lines() {
        let line = line.trim();
        total += part1(line);
    }

    println!("Total: {}", total);
}
