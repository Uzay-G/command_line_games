class Computer
    attr_accessor :code
    def initialize
        @code = 4.times.map{ (1 + Random.rand(6))}.join("")
    end
    def code
        @code
    end
end