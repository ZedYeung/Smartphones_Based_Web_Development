class Paper: Tool {

    init(strength: Int) {
        self.setStrength(strength: strength)
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
