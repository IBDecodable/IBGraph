//
//  IBGraphFrontend.swift
//  IBGraphFrontend
//
//  Created by phimage on 28/07/2019.
//

import Commandant

public struct IBGraphFrontend {

    public init() {}

    public func run() {
        let registry = CommandRegistry<CommandantError<()>>()
        registry.register(GenerateCommand())
        registry.register(HelpCommand(registry: registry))
        registry.register(VersionCommand())

        registry.main(defaultVerb: GenerateCommand().verb) { (error) in
            print(String.init(describing: error))
        }
    }
}
