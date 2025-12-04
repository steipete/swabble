import Foundation

struct SwabbleConfig: Codable, Sendable {
    struct Audio: Codable, Sendable {
        var deviceName: String = ""
        var deviceIndex: Int = -1
        var sampleRate: Double = 16_000
        var channels: Int = 1
    }

    struct Wake: Codable, Sendable {
        var enabled: Bool = true
        var word: String = "clawd"
        var aliases: [String] = ["claude"]
    }

    struct Hook: Codable, Sendable {
        var command: String = ""
        var args: [String] = []
        var prefix: String = "Voice swabble from ${hostname}: "
        var cooldownSeconds: Double = 1
        var minCharacters: Int = 24
        var timeoutSeconds: Double = 5
        var env: [String: String] = [:]
    }

    struct Logging: Codable, Sendable {
        var level: String = "info"
        var format: String = "text" // text|json placeholder
    }

    struct Transcripts: Codable, Sendable {
        var enabled: Bool = true
        var maxEntries: Int = 50
    }

    struct Speech: Codable, Sendable {
        var localeIdentifier: String = Locale.current.identifier
        var etiquetteReplacements: Bool = false
    }

    var audio = Audio()
    var wake = Wake()
    var hook = Hook()
    var logging = Logging()
    var transcripts = Transcripts()
    var speech = Speech()

    static let defaultPath = FileManager.default
        .homeDirectoryForCurrentUser
        .appendingPathComponent(".config/swabble/config.json")
}

enum ConfigError: Error {
    case missingConfig
}

enum ConfigLoader {
    static func load(at path: URL?) throws -> SwabbleConfig {
        let url = path ?? SwabbleConfig.defaultPath
        if !FileManager.default.fileExists(atPath: url.path) {
            throw ConfigError.missingConfig
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(SwabbleConfig.self, from: data)
    }

    static func save(_ config: SwabbleConfig, at path: URL?) throws {
        let url = path ?? SwabbleConfig.defaultPath
        let dir = url.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let data = try JSONEncoder().encode(config)
        try data.write(to: url)
    }
}
