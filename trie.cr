class Node(T)

    property char : Char?
    property children : Array(Node(T))?
    property is_word : Bool
    property data : T?

    def initialize()
        @is_word = false
    end

    def initialize(@char : Char)
        initialize()
    end
end

class Trie(T)

    property root : Node(T)

    def initialize
        @root = Node(T).new
    end

    def checkChildren(children : Array(Node), char : Char)
        children.each do |child|
            if child.char == char
                return child
            end
        end

        return nil
    end

    def add(word : String, data : T)
        current = @root

        word.squeeze do |char|
            if (children = current.children)
                current = checkChildren(children, char)

                if current
                    next
                end

                children << Node(T).new(char)
                current = children.last
            else
                current.children = Array(Node(T)).new

                newNode = Node(T).new(char)
                current.children.try(&.push(newNode))
                current = newNode
            end
        end

        current.is_word = true
        current.data = data
    end

    def search(word : String)
        current = @root

        word.squeeze do |char|
            if (children = current.children)
                current = checkChildren(children, char)

                if current
                    next
                else
                    return nil
                end
            end
        end

        return current
    end
end