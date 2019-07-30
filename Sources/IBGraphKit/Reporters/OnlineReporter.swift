//
//  OnlineReporter.swift
//  IBGraphKit
//
//  Created by phimage on 30/07/2019.
//

import Foundation

import SwiftGraph
import SwiftGraphBindings
import Cocoa

struct OnlineReporter: Reporter {

    static let identifier = "online"
    static let baseURL = "https://dreampuf.github.io/GraphvizOnline/#"
    static func generateReport(graph: IBGraph) -> String {
        let report = DOTReporter.generateReport(graph: graph)

        guard var component = URLComponents(string: baseURL) else {
            return "Failed to parse url \(baseURL)"
        }
        component.fragment = report
        guard let url = component.url else {
            return "Failed to create url for graph"
        }
        NSWorkspace.shared.open(url)

        return "Open url \(url)"
    }
}
