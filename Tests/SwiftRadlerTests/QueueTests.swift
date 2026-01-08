import Testing
@testable import SwiftRadler

@Suite("Queue FIFO behavior")
struct QueueFIFOTests {
    @Test("Push then pop maintains FIFO order")
    func fifoOrder() {
        var q = Queue<Int>()
        q.push(1)
        q.push(2)
        q.push(3)
        #expect(q.pop() == 1)
        #expect(q.pop() == 2)
        #expect(q.pop() == 3)
        #expect(q.pop() == nil)
    }

    @Test("Push contentsOf appends in order")
    func pushContentsOf() {
        var q = Queue<String>()
        q.push(contentsOf: ["a", "b"])
        q.push("c")
        #expect(q.pop() == "a")
        #expect(q.pop() == "b")
        #expect(q.pop() == "c")
        #expect(q.pop() == nil)
    }
}

@Suite("Queue indexing and removal")
struct QueueIndexingTests {
    @Test("Subscript returns correct elements")
    func subscriptAccess() {
        var q = Queue<Double>()
        q.push(1.5)
        q.push(2.5)
        q.push(3.5)
        #expect(q[0] == 1.5)
        #expect(q[1] == 2.5)
        #expect(q[2] == 3.5)
    }

    @Test("RemoveAll clears the queue")
    func removeAllClears() {
        var q = Queue<Int>()
        q.push(contentsOf: [1,2,3])
        q.removeAll()
        #expect(q.pop() == nil)
    }
}

@Suite("Queue edge cases")
struct QueueEdgeCaseTests {
    @Test("Pop on empty returns nil")
    func popEmpty() {
        var q = Queue<Int>()
        #expect(q.pop() == nil)
    }

    @Test("Interleaved push/pop operations")
    func interleavedOperations() {
        var q = Queue<Int>()
        q.push(10)
        #expect(q.pop() == 10)
        q.push(20)
        q.push(30)
        #expect(q.pop() == 20)
        q.push(40)
        #expect(q.pop() == 30)
        #expect(q.pop() == 40)
        #expect(q.pop() == nil)
    }
}
