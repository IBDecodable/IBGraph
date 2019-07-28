//
//  Vertexable.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import IBDecodable

protocol Vertexable {
    /// Return the vertex node.
    var vertex: Vertex { get }
}

extension StoryboardFile: Vertexable {
    var vertex: Vertex {
        return URL(fileURLWithPath: self.pathString).deletingPathExtension().lastPathComponent
    }
}

extension Scene: Vertexable {
    var vertex: Vertex { // XXX Find a better representation for scene
        return self.viewController?.viewController.id ?? self.viewControllerPlaceholder?.id ?? id
    }
}
