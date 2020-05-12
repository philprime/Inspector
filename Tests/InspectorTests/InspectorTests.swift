import XCTest
@testable import Inspector

final class InspectorTests: XCTestCase {

    func testExample() {
        do {
            let tempFolder = try TemproraryFolder()
            print(tempFolder.url)
            let file1 = File(name: "file1.txt", in: tempFolder)
            let file2 = File(name: "file2.txt", in: tempFolder)

            let subfolder1 = Folder(name: "subfolder1", in: tempFolder)

            let file3 = File(name: "file3.txt", in: subfolder1)
            let file4 = File(name: "file4.txt", in: subfolder1)

            let subfolder2 = Folder(name: "subfolder2", in: tempFolder)

            let file5 = File(name: "file5.txt", in: subfolder2)
            let file6 = File(name: "file6.txt", in: subfolder2)

            XCTAssertTrue(try file1.touch())
            XCTAssertTrue(try file2.touch())

            try subfolder1.create()
            XCTAssertTrue(try file3.touch())
            XCTAssertTrue(try file4.touch())

            try subfolder2.create()
            XCTAssertTrue(try file5.touch())
            XCTAssertTrue(try file6.touch())

            guard let testData = "ABCDEF".data(using: .utf8) else {
                XCTFail()
                return
            }
            try testData.write(to: file1)
            try testData.write(to: file2)
            try testData.write(to: file3)
            try testData.write(to: file4)
            try testData.write(to: file5)
            try testData.write(to: file6)

            XCTAssertEqual(tempFolder.size.bytes, 36)
            XCTAssertEqual(file1.size.bytes, 6)
            XCTAssertEqual(file2.size.bytes, 6)
            XCTAssertEqual(subfolder1.size.bytes, 12)
            XCTAssertEqual(file3.size.bytes, 6)
            XCTAssertEqual(file4.size.bytes, 6)
            XCTAssertEqual(subfolder2.size.bytes, 12)
            XCTAssertEqual(file5.size.bytes, 6)
            XCTAssertEqual(file6.size.bytes, 6)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
