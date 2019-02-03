//
//  Chapter2.swift
//  Algorithm
//
//  Created by Gelareh Taban on 1/4/19.
//  Copyright © 2019 Gelareh Taban. All rights reserved.
//

import Foundation

// *Problem 0*
// Write you own linked list implementation! For extra credit, make a doubly linked list! Make it generic!

public class Node<T> {
    
    var data: T
    var next: Node?
    var previous: Node?
    
    init(data: T) {
        self.data = data
    }

//    init(data: T, previous: Node) {
//        self.data = data
//        self.previous = previous
//        // set up the chain
//        previous.next = self
//    }
}

class List<T:Hashable> {
    
    private var head: Node<T>?
    private var tail: Node<T>?

    public var isEmpty: Bool {
        return head == nil
    }
    public var first: Node<T>? {
        return head
    }
    public var last: Node<T>? {
        return tail
    }
    
    init() {
    }
    
    public func add(_ value: T) {
        // create node
        let newNode = Node<T>(data: value)
        // check if list is not empty
        if let lastNode = tail {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            // list is empty
            head = newNode
        }
        tail = newNode
    }

    public func remove(index: Int) -> Bool {
        // Removes nodes at index, starting from 1 to n (size)
        
        guard (index > 0 && index <= size) else {
            return false
        }
        var current = 0
        if var currentNode = head {
            // get node at index
            current = 1
            while let nextNode = currentNode.next {
                if current == index { break }
                current += 1
                currentNode = nextNode
            }
            // remove node
            print("Node to remove \(currentNode.data), at \(current)")
            removeNode(currentNode)
//            if current == 1 {
//                // if node is at head
//                head = currentNode.next
//                head?.previous = nil
//
//            } else if current == size {
//                // node to remove at tail
//                tail = currentNode.previous
//                tail?.next = nil
//            } else {
//                // node is in the middle
//                let prevNode = currentNode.previous
//                prevNode?.next = currentNode.next
//                currentNode.next?.previous = prevNode
//            }
            
            return true
        } else {
            return false
        }
        
    }
    
    private func removeNode(_ node: Node<T>) {

        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            // if there is a previous, update previous to skip node and go to next
            prev.next = next
        }
        if let next = next {
            // if there is a next, update next to point to previous instead of node
            next.previous = prev
            
        }
        
        if prev == nil {
            // there was no previous -- this was head
            head = next
        }
        
        if next == nil {
            // there was no next -- this was tail
            tail = prev
        }
    }
    
    public var size: Int {
        return count()
    }

    private func count() -> Int {
        var length = 0
        
        if var node = head {
            length = 1
            while let nextNode = node.next {
                length += 1
                node = nextNode
            }
        }
        
        return length
    }
    
    public func printList() {
    
        if var node = head {
            var index = 1
            while let nextNode = node.next {
                print("[\(index)]=\(node.data)")
                node = nextNode
                index += 1
            }
            print("[\(index)]=\(node.data)")
        }

    }
    
    public func removeDuplicates() {
        print("Remove Duplicates")

        var freq: [T : Bool] = [:]
        
        // start at beginning
        if var currentNode = head {

            while (currentNode != nil) {
                // if node value already exists
                if let f = freq[currentNode.data], f == true {
                    removeNode(currentNode)
                } else {
                    freq[currentNode.data] = true
                }
                
                if let next = currentNode.next {
                    currentNode = next
                } else {
                    break
                }
            }
            

        }
        
    }
    
}


func testMyList() {
    
    let intList: List<Int> = List()
    intList.add(1)
    print("Length = \(intList.size)")
    intList.add(2)
    intList.add(3)
    intList.add(4)
    print("Length = \(intList.size)")
    intList.printList()
    _ = intList.remove(index: 3)
    intList.printList()
    // add lots of dup
    intList.add(4)
    intList.add(4)
    intList.add(4)
    intList.add(1)
    intList.add(2)
    intList.printList()
    // remove dup
    intList.removeDuplicates()
    intList.printList()
}

