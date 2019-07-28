//
//  JSONReporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation

struct JSONReporter: Reporter {

    static let identifier = "json"

    static func generateReport(graph: IBGraph) -> String {
        guard let data = try? JSONEncoder().encode(graph) else {
            return ""
        }
        return String(data: data, encoding: .utf8)!
    }
}
