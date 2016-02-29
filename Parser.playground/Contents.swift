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

func acceptableTerminalChar(char:Character, nextChar: Character?) -> Bool {
  let charAsStr = String(char)
  let nextCharAsStr = String(nextChar)
  
  print(charAsStr)
  print(nextCharAsStr)
  
  return false
}

enum ReadingStates: String {
  case ReadingTerminal = "ReadingTerminal"
  case ReadingNonterminal = "ReadingNonterminal"
}

func allowNPlusOne(index: Int, str: String) -> Bool {
  return index < str.characters.count ? true : false
}

func lex(var currentAttribute: String, index: Int, str: String, state: ReadingStates) {
  if allowNPlusOne(index, str: str){
    currentAttribute += String(str[str.startIndex.advancedBy(index)])
  } else {
    return
  }
  switch state {
  case .ReadingNonterminal:
    print(currentAttribute)
    if str[str.startIndex.advancedBy(index)] == "<" {
      lex(currentAttribute, index: index+1, str: str, state: .ReadingTerminal)
    } else {
      lex(currentAttribute, index: index+1, str: str, state: .ReadingNonterminal)
    }
  case .ReadingTerminal:
    if str[str.startIndex.advancedBy(index)] == ">" {
      lex(currentAttribute, index: index+1, str: str, state: .ReadingNonterminal)
    } else {
      lex(currentAttribute, index: index+1, str: str, state: .ReadingNonterminal)
    }
    print(acceptableTerminalChar(currentAttribute[currentAttribute.startIndex.advancedBy(index)], nextChar: allowNPlusOne(index+1, str: str) ? str[str.startIndex.advancedBy(index)] : nil))
    
  }
}

lex("", index: 0, str: str, state: str[str.startIndex.advancedBy(0)] == "<" ? .ReadingTerminal : .ReadingNonterminal)

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