class Rational
    def to_seconds
        (self* 24 * 60 * 60).to_i
    end
end

class String
    def js_safe
        self.gsub("\'", "\\\\'")
    end
end

class Integer
    def to_seconds
        self * 60
    end
end