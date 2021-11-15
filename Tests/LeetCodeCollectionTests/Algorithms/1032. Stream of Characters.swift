// 1032. Stream of Characters

import XCTest
protocol StreamCheckerProtocol {
    init(_:[String])
    func query(_ letter: Character) -> Bool
}

class StreamChecker:StreamCheckerProtocol{
    var root = TrieNode()
    var letterList: [Character] = []
    required init(_ words: [String]) {
        for word in words {
            var ws:TrieNode? = self.root
            for i in 1...word.count {
                let index = word.index(word.endIndex, offsetBy: -i)
                let char = word[index]
                ws?.children[char] = ws?.children[char] ?? TrieNode()
                ws = ws?.children[char]
            }
            ws?.isEndOfWord = true
        }
    }
    func query(_ letter: Character) -> Bool {
        self.letterList.append(letter)
        var ws:TrieNode? = self.root
        for i in 1...self.letterList.count {
            let char = self.letterList[self.letterList.count - i]
            if ws?.children[char] == nil {return false}
            ws = ws?.children[char]
            if ws?.isEndOfWord ?? false {return true}
        }
        return ws?.isEndOfWord ?? false
    }
}
class TrieNode {
    var children:[Character:TrieNode] = .init(minimumCapacity: 26)
    var isEndOfWord = false
}

class _StreamChecker:StreamCheckerProtocol {
    var trie = TrieNode()
    var linklist: Node?
    required init(_ words: [String]) {
        for word in words {
            wordHandler(trie, word)
        }
    }
    @inlinable
    func wordHandler(_ trie: TrieNode, _ word: String) {
        var node: TrieNode? = trie
        let array:ReversedCollection<String> = word.reversed()
        for letter:Character in array {
            node?.dict[letter] = node?.dict[letter] ?? TrieNode()
            node = node?.dict[letter]
        }
        
        node?.end = true
    }
    @inlinable
    func query(_ letter: Character) -> Bool {
        let newNode:Node = Node(letter)
        linklist = newNode.next(linklist)
        return search(trie, linklist)
    }
    @inlinable
    func search(_ trie: TrieNode, _ node: Node?) -> Bool {
        var currectNode: Node? = node
        var currectTrie: TrieNode? = trie
        while true {
            guard
                let currentChar = currectNode?.val,
                let charTrie = currectTrie?.dict[currentChar]
            else {
                return false
            }
            if charTrie.end {return true}
            currectTrie = charTrie
            currectNode = currectNode?.next
        }
    }

    class TrieNode {
        var dict = [Character: TrieNode]()
        var end: Bool = false
    }

    class Node {
        var val: Character
        var next: Node?
        
        init(_ val: Character) {
            self.val = val
        }
        @inlinable
        func next(_ node:Node?) -> Node {
            self.next = node
            return self
        }
    }
}

/**
 * Your StreamChecker object will be instantiated and called as such:
 * let obj = StreamChecker(words)
 * let ret_1: Bool = obj.query(letter)
 */

class _1032_Stream_of_Characters: XCTestCase {
    func testSample() {
        let streamChecker:StreamCheckerProtocol = _StreamChecker(["cd","f","kl"]); // init the dictionary.
        XCTAssertEqual(false,streamChecker.query("a"));          // return false
        XCTAssertEqual(false,streamChecker.query("b"));          // return false
        XCTAssertEqual(false,streamChecker.query("c"));          // return false
        XCTAssertEqual(true,streamChecker.query("d"));          // return true, because "cd" is in the wordlist
        XCTAssertEqual(false,streamChecker.query("e"));          // return false
        XCTAssertEqual(true,streamChecker.query("f"));          // return true, because "f" is in the wordlist
        XCTAssertEqual(false,streamChecker.query("g"));          // return false
        XCTAssertEqual(false,streamChecker.query("h"));          // return false
        XCTAssertEqual(false,streamChecker.query("i"));          // return false
        XCTAssertEqual(false,streamChecker.query("j"));          // return false
        XCTAssertEqual(false,streamChecker.query("k"));          // return false
        XCTAssertEqual(true,streamChecker.query("l"));          // return true
    }
}
