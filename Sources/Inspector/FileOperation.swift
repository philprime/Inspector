import Foundation

/// Helper structure used to define a list of necessary file operations
public enum FileOperation {

    case write(data: Data, to: File)
    case copyFile(from: File, to: File)
    case copyFolder(from: Folder, to: Folder)

}
