@testable import workday_solution
import XCTest
import Hippolyte
import Cache

class CacheTests: XCTestCase {

    var cache:Storage?
    private let key = String(describing: MediaItem.self)
    private let testObject = MediaItem()
    
    override func setUp() {
        super.setUp()
        Hippolyte.shared.start()
        do {
            self.cache = try Cache.sharedInstance.getCache()
        } catch {
            XCTFail()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        Hippolyte.shared.stop()
        try? self.cache?.removeAll()
        self.cache = nil
    }
    
    func testInit() {
        // Test that it creates cache directory
        guard let _ = self.cache else {
            XCTFail()
            return
        }
        XCTAssert(true)
    }
    
    func testSaveObject() throws {
        try self.cache?.setObject(testObject, forKey: key)
        let entry = try self.cache?.entry(ofType: MediaItem.self, forKey: key)
        XCTAssertEqual(entry?.object.name, testObject.name)
        XCTAssertEqual(entry?.object.url, testObject.url)
    }
    
    func testRetrieveObject() throws {
        try self.cache?.setObject(testObject, forKey: key)
        let entry = try self.cache?.entry(ofType: MediaItem.self, forKey: key)
        XCTAssertEqual(entry?.object.name, testObject.name)
        XCTAssertEqual(entry?.object.url, testObject.url)
    }
    
    func testObjectExists() throws {
        try self.cache?.setObject(testObject, forKey: key)
        let exists = try self.cache?.existsObject(ofType: MediaItem.self, forKey: key)
        guard let uExists = exists else {
            XCTFail()
            return
        }
        XCTAssert(uExists)
    }
    
}
