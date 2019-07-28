//
//  Reporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

public protocol Reporter {
    static var identifier: String { get }

    static func generateReport(graph: IBGraph) -> String
}

public struct Reporters {

    public static func reporter(from reporter: String) -> Reporter.Type {
        switch reporter {
        case DefaultReporter.identifier:
            return DefaultReporter.self
        case DOTReporter.identifier:
            return DOTReporter.self
        case JSONReporter.identifier:
            return JSONReporter.self
        case GraphMLReporter.identifier:
            return GraphMLReporter.self
        case GMLReporter.identifier:
            return GMLReporter.self
        default:
            fatalError("no reporter with identifier '\(reporter) available'")
        }
    }
}
