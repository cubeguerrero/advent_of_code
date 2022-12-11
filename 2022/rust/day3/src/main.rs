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

fn get_intersection(s1: &str, s2: &str) -> Vec<char> {
    let set1 = string_to_set(s1);
    let set2 = string_to_set(s2);

    set1.intersection(&set2)
        .map(|x: &char| x.to_owned())
        .collect()
}

fn part1(contents: &str) {
    let mut total = 0;
    for line in contents.lines() {
        let line = line.trim();
        let mid = line.len() / 2;
        let intersection = get_intersection(&line[0..mid], &line[mid..(line.len())]);
        let letter = intersection[0];
        total += get_score(letter);
    }

    println!("Part 1: {}", total);
}

fn part2(contents: &str) {}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failed to read input file");
    part1(&contents);
}
