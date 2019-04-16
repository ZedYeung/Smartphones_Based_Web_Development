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
