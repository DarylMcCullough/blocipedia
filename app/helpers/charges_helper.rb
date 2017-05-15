module ChargesHelper
    def self.formatCents(d)
        dollars = d/100
        cents = d % 100
        if cents < 10
            return "$#{dollars}.0#{cents}"
        end
        return "$#{dollars}.#{cents}"
    end
end
