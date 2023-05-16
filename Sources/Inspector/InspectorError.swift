import Foundation

public enum InspectorError: LocalizedError {

    case invalidTempFileTemplate
    case failedToCreateFile(String)
    case targetAlreadyExists

    public var errorDescription: String? {
        switch self {
        case .invalidTempFileTemplate:
            return "Invalid temporary file template"
        case .failedToCreateFile(let string):
            return "Failed to create error at path: \(string)"
        case .targetAlreadyExists:
            return "Target already exists"
        }
    }
}
