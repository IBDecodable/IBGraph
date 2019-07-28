//
//  DOTReporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation

import SwiftGraph
import SwiftGraphBindings
import DotSwiftEncoder

struct DOTReporter: Reporter {

    static let identifier = "dot"

    static func generateReport(graph: IBGraph) -> String {
        return DOTEncoder(type: .digraph).encode(graph)
    }
}
