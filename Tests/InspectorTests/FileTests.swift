import XCTest
@testable import Inspector

class FileTests: XCTestCase {

    // MARK: - Testing fileName

    func testFileName_withoutPathExtension_shouldReturnFullName() {
        let file = File(path: "/foo/bar/name")
        XCTAssertEqual(file.name, "name")
        XCTAssertEqual(file.fileName, "name")
    }

    func testFileName_withSinglePathExtension_shouldReturnNameWithoutExtension() {
        let file = File(path: "/foo/bar/name.ext")
        XCTAssertEqual(file.name, "name.ext")
        XCTAssertEqual(file.fileName, "name")
    }

    func testFileName_withMultiplePathExtensions_shouldReturnNameWithoutLastExtensions() {
        let file = File(path: "/foo/bar/name.ext1.ext2")
        XCTAssertEqual(file.name, "name.ext1.ext2")
        XCTAssertEqual(file.fileName, "name.ext1")
    }
}
