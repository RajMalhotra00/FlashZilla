//
//  Card.swift
//  Flashzilla
//
//  Created by Raj Malhotra on 10.04.21.
//

import SwiftUI

struct Card {
    let prompt: String
    let answer: String
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
