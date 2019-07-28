//
//  GMLReporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import DotSwiftEncoder

struct GMLReporter: Reporter {

    static let identifier = "gml"

    static func generateReport(graph: IBGraph) -> String {
        var string = """
graph [
       directed 1
"""
        let nodes = graph.enumerated().map { arg -> Node in
            let (i, v) = arg
            return Node(id: i, label: v.description)
        }

        for node in nodes {
string += """
\n       node [
             id \(node.id)
             label "\(node.label)"
            ]
"""
        }
        for edge in graph.edgeList() {
            string += """
\n       edge [
             source \(edge.u)
             target \(edge.v)
            ]
"""
        }
        string += "\n]"
        return string
    }
}
