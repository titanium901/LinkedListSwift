
// Node
final class Node {
    var value: Int
    var next: Node?

    init(value: Int, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

// Create some nodes
let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

// link nodes
node1.next = node2
node2.next = node3

// Create Linked list
struct LinkedList {
    var head: Node?
    var tail: Node?

    var isEmpty: Bool {
        head == nil
    }

    // add element O(1)
    mutating func push(_ value: Int) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }

    mutating func append(_ value: Int) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }

    mutating func insert(_ value: Int, after node: Node) {
        guard tail !== node else {
            append(value)
            return
        }
        node.next = Node(value: value, next: node)
    }

    // O(1)
    mutating func pop() -> Int? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }

    // O(n)
    mutating func removeLast() -> Int? {
        guard let head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }

        var prev = head
        var current = head

        while let next = current.next {
            prev = current
            current = next
        }

        prev.next = nil
        tail = prev

        return current.value
    }

    // O(1)
    mutating func remove(after node: Node) -> Int? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }

    func node(at index: Int) -> Node? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }

    mutating func reverse() {
        tail = head
        var prev: Node?
        var current = head
        while current != nil {
             let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }


    func printList() {
        var currentNode = head
        while currentNode != nil {
            print(currentNode?.value ?? 0)
            currentNode = currentNode?.next
        }
    }
}

var linkedList = LinkedList()

linkedList.push(3)
linkedList.push(2)
linkedList.push(1)

linkedList.append(4)

let someNode = linkedList.node(at: 3)!
linkedList.insert(0, after: someNode)

// linkedList.pop()
// linkedList.removeLast()
linkedList.remove(after: someNode)

linkedList.printList()
print("---------")

// Reverse
var oneList = LinkedList()

oneList.append(1)
oneList.append(2)
oneList.append(3)
oneList.append(4)
oneList.append(5)

oneList.reverse()
print("Reversed List")

oneList.printList()

func mergeSortedLists(left: LinkedList, right: LinkedList) -> LinkedList {
    guard !left.isEmpty else { return right }
    guard !right.isEmpty else { return left }

    var head: Node?
    var tail: Node?
    var currentLeft = left.head
    var currentRight = right.head

    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            head = leftNode
            currentLeft = leftNode.next
        } else {
            head = rightNode
            currentRight = rightNode.next
        }
        tail = head
    }

    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }

    if let leftRemained = currentLeft {
        tail?.next = leftRemained
    }
    if let rightRemained = currentRight {
        tail?.next = rightRemained
    }
    while let next = tail?.next {
        tail = next
    }

    var newList = LinkedList()
    newList.head = head
    newList.tail = tail
    return newList
}

var listOne = LinkedList()
listOne.append(1)
listOne.append(2)
listOne.append(3)

var listTwo = LinkedList()
listTwo.append(-2)
listTwo.append(-1)
listTwo.append(0)

let mergedList = mergeSortedLists(left: listOne, right: listTwo)

print("---------")
print("mergedList")
mergedList.printList()
