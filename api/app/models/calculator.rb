class Calculator 
    attr_accessor :n1, :n2
    def initialize(n1:, n2:)
        @n1 = n1
        @n2 = n2
    end
    def devide 
        @n1/ @n2
    end
    def multiply 
        @n1 * @n2
    end
    def square 
        @n1 * @n1
    end
    def cube 
        @n1 * @n1 * @n1
    end
end