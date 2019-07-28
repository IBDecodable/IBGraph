//
//  DefaultReporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation

struct DefaultReporter: Reporter {

    static let identifier = "default"

    static func generateReport(graph: IBGraph) -> String {
        return graph.description
    }
}
