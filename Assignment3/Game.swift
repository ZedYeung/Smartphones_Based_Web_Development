class Tool {
    var strength = 0
    var type = ""

    init(strength: Int) {
        self.strength = strength
    }

    func setStrength(strength: Int) {
        self.strength = strength
    }
}


class Paper: Tool {

    override init(strength: Int) {
        super.init(strength: strength)
        self.type = "p"
    }

    func fight(with other: Tool) -> Bool {
        var strength = self.strength
        if other.type == "r" {
            strength *= 2
        } else if other.type == "s" {
            strength /= 2
        }
        return strength > other.strength
    }
}


class Scissors: Tool {

    override init(strength: Int) {
        super.init(strength: strength)
        self.type = "s"
    }

    func fight(with other: Tool) -> Bool {
        var strength = self.strength
        if other.type == "p" {
            strength *= 2
        } else if other.type == "r" {
            strength /= 2
        }
        return strength > other.strength
    }
}

class Rock: Tool {

    override init(strength: Int) {
        super.init(strength: strength)
        self.type = "r"
    }

    func fight(with other: Tool) -> Bool {
        var strength = self.strength
        if other.type == "s" {
            strength *= 2
        } else if other.type == "p" {
            strength /= 2
        }
        return strength > other.strength
    }
}

func calculateResults() {
    let rock = Rock(strength: 15)
    let scissors = Scissors(strength: 5)
    let paper = Paper(strength: 15)
    print("rock-scissors: \(rock.fight(with: scissors )) - \(scissors.fight(with: rock))")
    print("scissors-paper: \(scissors.fight(with: paper )) - \(paper.fight(with: scissors))")
    print("paper-rock: \(paper.fight(with: rock )) - \(rock.fight(with: paper))")
}

calculateResults()
