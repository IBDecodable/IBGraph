//
//  GraphMLReporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import DotSwiftEncoder

struct GraphMLReporter: Reporter {

    static let identifier = "graphml"

    static func generateReport(graph: IBGraph) -> String {
        var string = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE graphml SYSTEM "http://www.graphdrawing.org/dtds/graphml.dtd">
<graphml>
 <graph id="G" edgedefault="directed">
"""
        let nodes = graph.enumerated().map { arg -> Node in
            let (i, v) = arg
            return Node(id: i, label: v.description)
        }

        for node in nodes {
            string += """

   <node id="\(node.id)">
    <data key="d\(node.id)">
     <y:ShapeNode>
      <y:NodeLabel>\(node.label)</y:NodeLabel>
      <y:Shape type="rectangle"/>
     </y:ShapeNode>
    </data>
   </node>
 """
        }
        for (index, edge) in graph.edgeList().enumerated() {
            string += "\n  <edge id=\"e\(index)\" source=\"\(edge.u)\" target=\"\(edge.v)\"/>"
        }
        string += "\n </graphml>"
        string += "\n</graphml>"
        return string
    }
}
