@testable import MultipartForm
import XCTest

final class MultipartFormTests: XCTestCase {
    func testExample() throws {
        let imageURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("2.png")
        let imageData = try Data(contentsOf: imageURL)
        
        let formURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("exampleForm")
        let formData = try Data(contentsOf: formURL)
        
        let form = MultipartForm(parts: [
            MultipartForm.Part(name: "a", value: "1"),
            MultipartForm.Part(name: "b", data: imageData, filename: "b.txt", contentType: "text/plain"),
            MultipartForm.Part(name: "c", value: "3"),
        ], boundary: "9BFDAA7B-7244-4DA8-916B-2311D3CD1FEE")
        
        XCTAssertEqual(form.bodyData, formData)
    }
    
    func testContentType() {
        let form = MultipartForm(boundary: "9BFDAA7B-7244-4DA8-916B-2311D3CD1FEE")
        
        XCTAssertEqual(form.contentType, "multipart/form-data; boundary=9BFDAA7B-7244-4DA8-916B-2311D3CD1FEE")
    }
    
    func testSubscriptGet() {
        let form = MultipartForm(parts: [
            MultipartForm.Part(name: "a", value: "1"),
            MultipartForm.Part(name: "a", value: "2"),
            MultipartForm.Part(name: "c", value: "3"),
        ])
        
        XCTAssertEqual(form["a"]?.value, "1")
        XCTAssertNil(form["b"])
        XCTAssertEqual(form["c"]?.value, "3")
    }
    
    func testSubscriptSet() {
        var form = MultipartForm(parts: [
            MultipartForm.Part(name: "a", value: "1"),
            MultipartForm.Part(name: "a", value: "2"),
            MultipartForm.Part(name: "c", value: "3"),
        ])
        
        form["a"] = MultipartForm.Part(name: "a", value: "3")
        XCTAssertEqual(form["a"]?.value, "3")
        
        XCTAssertEqual(form.parts, [
            MultipartForm.Part(name: "c", value: "3"),
            MultipartForm.Part(name: "a", value: "3"),
        ])
    }
    
    func testGetValue() {
        let part = MultipartForm.Part(name: "a", data: "1".data(using: .utf8)!)
        
        XCTAssertEqual(part.value, "1")
    }
    
    func testSetValue() {
        var part = MultipartForm.Part(name: "a", value: "1")
        
        part.value = "2"
        XCTAssertEqual(part.value, "2")
        XCTAssertEqual(part.data, "2".data(using: .utf8)!)
    }
    
    func testSetNilValue() {
        var part = MultipartForm.Part(name: "a", value: "1")
        
        part.value = nil
        XCTAssertEqual(part.value, "")
        XCTAssertEqual(part.data, Data())
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testContentType", testContentType),
        ("testSubscriptGet", testSubscriptGet),
        ("testSubscriptSet", testSubscriptSet),
        ("testGetValue", testGetValue),
        ("testSetValue", testSetValue),
        ("testSetNilValue", testSetNilValue),
    ]
}
