//
//  Vertexable.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import IBDecodable

protocol Vertexable {
    /// Return id for the vertex node.
    var vertex: String { get }
}

extension StoryboardFile: Vertexable {
    var vertex: String {
        return URL(fileURLWithPath: self.pathString).deletingPathExtension().lastPathComponent
    }
}

extension Scene: Vertexable {
    var vertex: String { // XXX Find a better representation for scene
        return self.viewController?.viewController.id ?? self.viewControllerPlaceholder?.id ?? id
    }
}
