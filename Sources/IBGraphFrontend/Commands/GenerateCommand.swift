//
//  GenerateCommand.swift
//  IBGraphFrontend
//
//  Created by phimage on 28/07/2019.
//

import Result
import Foundation
import IBDecodable
import IBGraphKit
import Commandant
import PathKit

struct GenerateCommand: CommandProtocol {
    typealias Options = GenerateOptions
    typealias ClientError = Options.ClientError

    let verb: String = "generate"
    var function: String = "Show graph (default command)"

    func run(_ options: GenerateCommand.Options) -> Result<(), GenerateCommand.ClientError> {
        let workDirectoryString = options.path ?? FileManager.default.currentDirectoryPath
        let workDirectory = URL(fileURLWithPath: workDirectoryString)
        guard FileManager.default.isDirectory(workDirectory.path) else {
            fatalError("\(workDirectoryString) is not directory.")
        }

        let config = Config(options: options) ?? Config.default
        let graphBuilder = GraphBuilder()
        let graph = graphBuilder.graph(workDirectory: workDirectory, config: config)

        let reporter = Reporters.reporter(from: options.reporter ?? config.reporter)
        let report = reporter.generateReport(graph: graph)
        print(report)

        if graph.isEmpty {
            exit(2)
        } else {
            return .success(())
        }
    }
}

struct GenerateOptions: OptionsProtocol {
    typealias ClientError = CommandantError<()>

    let path: String?
    let reporter: String?
    let configurationFile: String?

    static func create(_ path: String?) -> (_ reporter: String?) -> (_ config: String?) -> GenerateOptions {
        return { reporter in
            return { config in
                self.init(path: path, reporter: reporter, configurationFile: config)
            }
        }
    }

    static func evaluate(_ mode: CommandMode) -> Result<GenerateCommand.Options, CommandantError<GenerateOptions.ClientError>> {
        return create
            <*> mode <| Option(key: "path", defaultValue: nil, usage: "validate project root directory")
            <*> mode <| Option(key: "reporter", defaultValue: nil, usage: "the reporter used to show graph")
            <*> mode <| Option(key: "config", defaultValue: nil, usage: "the path to IBGraph's configuration file")
    }
}

extension Config {
    init?(options: GenerateOptions) {
        if let configurationFile = options.configurationFile {
            let configurationURL = URL(fileURLWithPath: configurationFile)
            try? self.init(url: configurationURL)
        } else {
            let workDirectoryString = options.path ?? FileManager.default.currentDirectoryPath
            let workDirectory = URL(fileURLWithPath: workDirectoryString)
            try? self.init(directoryURL: workDirectory)
        }
    }
}
