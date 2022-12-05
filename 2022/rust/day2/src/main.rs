use std::collections::HashMap;
use std::fs;

fn rock_paper_scissors(move1: &str, move2: &str) -> i8 {
    if move1 == move2 {
        0
    } else {
        if move1 == "rock" {
            if move2 == "paper" {
                -1
            } else {
                1
            }
        } else if move1 == "paper" {
            if move2 == "scissors" {
                -1
            } else {
                1
            }
        } else {
            if move2 == "rock" {
                -1
            } else {
                1
            }
        }
    }
}

fn get_move_score(m: &str) -> i32 {
    if m == "rock" {
        1
    } else if m == "paper" {
        2
    } else {
        3
    }
}

fn get_move<'a>(move1: &'a str, a: &'a str) -> &'a str {
    if a == "Y" {
        move1
    } else if a == "X" {
        if move1 == "rock" {
            "scissors"
        } else if move1 == "paper" {
            "rock"
        } else {
            "paper"
        }
    } else {
        if move1 == "rock" {
            "paper"
        } else if move1 == "paper" {
            "scissors"
        } else {
            "rock"
        }
    }
}

fn main() {
    let move1_mapping = HashMap::from([("A", "rock"), ("B", "paper"), ("C", "scissors")]);
    // let move2_mapping = HashMap::from([("X", "rock"), ("Y", "paper"), ("Z", "scissors")]); part 1
    let mut total_points = 0;
    let contents = fs::read_to_string("input.txt").unwrap();

    for line in contents.lines() {
        let moves = line.split(" ").collect::<Vec<&str>>();
        let move1 = *move1_mapping.get(&moves[0]).unwrap();
        // let move2 = *move2_mapping.get(&moves[1]).unwrap(); part 1
        let move2 = get_move(move1, &moves[1]);
        total_points += get_move_score(move2);

        match rock_paper_scissors(move1, move2) {
            0 => total_points += 3,
            -1 => total_points += 6,
            _ => (),
        }
    }

    println!("{}", total_points);
}
