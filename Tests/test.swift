

import XCTest

import IBDecodable

import SwiftGraph
import SwiftGraphBindings
import DotSwiftEncoder

@testable import IBGraphKit

class Tests: XCTestCase {
    let urls = [url("First", "xml"), url("Second", "xml")]

    func testGraphStoryboard() {
        let files: [StoryboardFile] = urls.compactMap { try? StoryboardFile(url: $0) }

        let graph = files.graph()
        XCTAssertFalse(graph.isEmpty)

        print(DOTEncoder(type: .digraph).encode(graph))
    }

    func testGraphViewController() {
        let files: [StoryboardFile] = urls.compactMap { try? StoryboardFile(url: $0) }

        let graph = files.graph(type: .viewController)
        XCTAssertFalse(graph.isEmpty)

        print(DOTEncoder(type: .digraph).encode(graph))
    }
}

func url(_ name: String, _ ext: String) -> URL {
    return Bundle(for: Tests.self).url(forResource: name, withExtension: ext) ?? URL(fileURLWithPath: "Tests/\(name).\(ext)")
}
