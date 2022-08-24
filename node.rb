
class Node
    attr_accessor :data , :right_child , :left_child
    def initialize(data = nil , left_child = nil , right_child = nil)
        @data = data
        @left_child = left_child
        @right_child =right_child
    end
end