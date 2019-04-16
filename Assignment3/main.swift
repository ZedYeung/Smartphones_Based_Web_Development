func calculateResults() {
    let rock = Rock(strength: 15)
    let scissors = Scissors(strength: 5)
    let paper = Paper(strength: 15)
    print("rock-scissors: \(rock.fight(with: scissors )) - \(scissors.fight(with: rock))")
    print("scissors-paper: \(scissors.fight(with: paper )) - \(paper.fight(with: scissors))")
    print("paper-rock: \(paper.fight(with: rock )) - \(rock.fight(with: paper))")
}

calculateResults()