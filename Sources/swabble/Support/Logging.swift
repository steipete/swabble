import Foundation

enum LogLevel: String, Comparable, CaseIterable {
    case trace, debug, info, warn, error

    var rank: Int {
        switch self {
        case .trace: 0
        case .debug: 1
        case .info: 2
        case .warn: 3
        case .error: 4
        }
    }

    static func < (lhs: LogLevel, rhs: LogLevel) -> Bool { lhs.rank < rhs.rank }
}

struct Logger: Sendable {
    let level: LogLevel

    init(level: LogLevel) { self.level = level }

    func log(_ level: LogLevel, _ message: String) {
        guard level >= self.level else { return }
        let ts = ISO8601DateFormatter().string(from: Date())
        print("[\(level.rawValue.uppercased())] \(ts) | \(message)")
    }

    func trace(_ msg: String) { log(.trace, msg) }
    func debug(_ msg: String) { log(.debug, msg) }
    func info(_ msg: String) { log(.info, msg) }
    func warn(_ msg: String) { log(.warn, msg) }
    func error(_ msg: String) { log(.error, msg) }
}

extension LogLevel {
    init?(configValue: String) {
        self.init(rawValue: configValue.lowercased())
    }
}
