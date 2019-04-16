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