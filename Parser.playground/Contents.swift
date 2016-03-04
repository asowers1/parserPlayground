//: Playground - noun: a place where people can play

import UIKit

var str = "Hi there! <b>Hello</b>, <u>playground</u>"

class QNode<T> {
  var value: T
  var next: QNode?
  
  init(item:T) {
    value = item
  }
}


public struct TSQueue<T> {
  private var top: QNode<T>!
  private var bottom: QNode<T>!
  
  public init() {
    top = nil
    bottom = nil
  }
  
  public mutating func enQueue(item: T) {
    
    let newNode:QNode<T> = QNode(item: item)
    
    if top == nil {
      top = newNode
      bottom = top
      return
    }
    
    bottom.next = newNode
    bottom = newNode
  }
  
  public mutating func deQueue() -> T? {
    
    let topItem: T? = top?.value
    if topItem == nil {
      return nil
    }
    
    if let nextItem = top.next {
      top = nextItem
    } else {
      top = nil
      bottom = nil
    }
    
    return topItem
  }
  
  public func isEmpty() -> Bool {
    
    return top == nil ? true : false
  }
  
  public func peek() -> T? {
    return top?.value
  }
  
}

typealias b = String
typealias e = String
typealias i = String
typealias small = String
typealias s = String
typealias u = String
typealias color = String

enum Element: String {
  case b = "b"
  case e = "e"
  case i = "i"
  case small = "small"
  case s = "s"
  case u = "u"
  case color = "color"
}

struct Attribute {
  var string: String?
  var attributeName: String?
  var value: AnyObject
}

struct State<T> {
  var keyword: T
  init(keyword: T) {
    self.keyword = keyword
  }
}

func acceptableTerminalChar(char:Character, nextChar: Character) -> Bool {
    let charAsStr = String(char)
    let nextCharAsStr = String(nextChar)
    switch charAsStr {
    case "<":
    switch nextCharAsStr {
    case "b": return true
    case "e": return true
    case "i": return true
    case "s": return true
    case "u": return true
    case "c": return true
    default: return false
    }
    case ">": return true
    case "/":
    switch nextCharAsStr {
    case "b": return true
    case "c": return true
    case "e": return true
    case "i": return true
    case "s": return true
    case "u": return true
    default: return true
    }
    case "a":
    switch nextCharAsStr {
    case "l": return true
    default: return false
    }
    case "b":
    switch nextCharAsStr {
    case ">": return true
    default: return false
    }
    case "c":
    switch nextCharAsStr {
    case "o": return true
    default: return false
    }
    case "e":
    switch nextCharAsStr {
    case ">": return true
    default: return false
    }
    case "i":
    switch nextCharAsStr {
    case ">": return true
    default: return false
    }
    case "l":
    switch nextCharAsStr {
    case "o": return true
    case "l": return true
    case ">": return true
    default: return false
    }
    case "o":
    switch nextCharAsStr {
    case "l": return true
    case "r": return true
    default: return false
    }
    case "s":
    switch nextCharAsStr {
    case "m": return true
    case ">": return true
    default: return false
    }
    case "u":
    switch nextCharAsStr {
    case ">": return true
    default: return false
    }
    default: return false
    }
}

var strArr = [String]()

enum ReadingStates: String {
  case ReadingTerminal = "ReadingTerminal"
  case ReadingNonterminal = "ReadingNonterminal"
}

func allowNPlusOne(index: Int, str: String) -> Bool {
  return index < str.characters.count ? true : false
}

func lex(var currentAttribute: String, index: Int, source: String, state: ReadingStates, var currentLexeme: String? = nil) {
  if allowNPlusOne(index, str: source){
    currentAttribute += String(source[source.startIndex.advancedBy(index)])
  } else {
    return
  }
  switch state {
  case .ReadingNonterminal:
    
    if source[source.startIndex.advancedBy(index)] == "<" {
        if let _ = currentLexeme {
            strArr.append(currentLexeme!)
        }
        lex(currentAttribute, index: index+1, source: source, state: .ReadingTerminal, currentLexeme: "<")
    } else {
        if let _ = currentLexeme {
            currentLexeme = currentLexeme! + String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
        } else {
            currentLexeme = String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
        }
        lex(currentAttribute, index: index+1, source: source, state: .ReadingNonterminal, currentLexeme: currentLexeme)
    }
    
  case .ReadingTerminal:
    if allowNPlusOne(index+1, str: source) {
        if acceptableTerminalChar(currentAttribute[currentAttribute.startIndex.advancedBy(index)], nextChar: str[str.startIndex.advancedBy(index+1)]) {
            if let _ = currentLexeme {
                currentLexeme = currentLexeme! + String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
            } else {
                currentLexeme = String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
            }
        }
    } else {
        // done, so try and build the tree
        if source[source.startIndex.advancedBy(index)] == ">" {
            if let _ = currentLexeme {
                currentLexeme = currentLexeme! + ">"
            }
        }
    }
    if source[source.startIndex.advancedBy(index)] == ">" {
        print(currentLexeme!)
        strArr.append(currentLexeme!)
        currentLexeme = nil
        lex(currentAttribute, index: index+1, source: source, state: .ReadingNonterminal, currentLexeme: currentLexeme)
    } else {
        lex(currentAttribute, index: index+1, source: source, state: .ReadingTerminal, currentLexeme: currentLexeme)
    }
    
  }
}

lex("", index: 0, source: str, state: str[str.startIndex.advancedBy(0)] == "<" ? .ReadingTerminal : .ReadingNonterminal)


for str in strArr {
    print(str)
}

func applyAttricutes() { // this will take in the queue of attributes and apply their properties to the string. Finally, it should return the fully attributed string
  
}

extension String {
  
  subscript (i: Int) -> Character {
    return self[self.startIndex.advancedBy(i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    let start = startIndex.advancedBy(r.startIndex)
    let end = start.advancedBy(r.endIndex - r.startIndex)
    return self[Range(start: start, end: end)]
  }
}
