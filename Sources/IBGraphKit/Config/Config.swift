//
//  Config.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import Yams

public struct Config: Codable {
    public let excluded: [String]
    public let included: [String]
    public let reporter: String
    public let type: IBGraphType

    enum CodingKeys: String, CodingKey {
        case excluded
        case included
        case reporter
        case type
    }

    public static let fileName = ".ibgraph.yml"
    public static let `default` = Config.init()
    public static let defaultReporter = "dot"

    private init() {
        excluded = []
        included = []
        reporter = Config.defaultReporter
        type = .default
    }

    init(excluded: [String] = [], included: [String] = [], reporter: String = Config.defaultReporter) {
        self.excluded = excluded
        self.included = included
        self.reporter = reporter
        self.type = .default
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        excluded = try container.decodeIfPresent(Optional<[String]>.self, forKey: .excluded).flatMap { $0 } ?? []
        included = try container.decodeIfPresent(Optional<[String]>.self, forKey: .included).flatMap { $0 } ?? []
        reporter = try container.decodeIfPresent(String.self, forKey: .reporter) ?? Config.defaultReporter
        type = try container.decodeIfPresent(IBGraphType.self, forKey: .type) ?? .default
    }

    public init(url: URL) throws {
        self = try YAMLDecoder().decode(from: String.init(contentsOf: url))
    }

    public init(directoryURL: URL, fileName: String = fileName) throws {
        let url = directoryURL.appendingPathComponent(fileName)
        try self.init(url: url)
    }
}
