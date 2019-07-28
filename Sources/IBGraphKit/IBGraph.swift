//
//  IBGraph.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//
import Foundation

import IBDecodable

import SwiftGraph
import SwiftGraphBindings

public typealias IBGraph = UnweightedGraph<String>

public enum IBGraphType: String, Codable {
    case storyboard
    case viewController

    static let `default`: IBGraphType = .storyboard
}

public extension Sequence where Element == StoryboardFile {

    func graph(type: IBGraphType = .storyboard) -> UnweightedGraph<String> {
        let graph = UnweightedGraph<String>()

        var vertexes: [String: Int] = [:]
        // Add vertex
        for file in self {
            switch type {
            case .storyboard:
                let vertex = file.vertex
                let index = graph.addVertex(vertex)
                vertexes[vertex] = index
            case .viewController:
                if let scenes = file.document.scenes {
                    for scene in scenes {
                        let vertex = scene.vertex
                        let index = graph.addVertex(vertex)
                        vertexes[vertex] = index
                    }
                }
            }
        }

        // Add link in second phrase
        for file in self {
            let vertex = file.vertex
            if let scenes = file.document.scenes {
                for scene in scenes {
                    switch type {
                    case .storyboard:
                        // Link to other storyboard
                        if let placeHolder = scene.viewControllerPlaceholder {
                            let reference = placeHolder.storyboardName
                            // print("\(vertex) -> \(reference)")
                            graph.addEdge(from: vertex, to: reference, directed: true)
                            // graph.addEdge(fromIndex: vertexes[vertex]!, toIndex: vertexes[reference]!)
                        }
                    case .viewController:
                        let vertex = scene.vertex
                        let segues: [Segue] = scene.children(of: Segue.self, recursive: true)
                        for segue in segues {
                            let reference = segue.destination
                            // print("\(vertex) -> \(reference)")s
                            graph.addEdge(from: vertex, to: reference, directed: true)
                        }
                    }
                }
            }
        }
        return graph
    }
}
