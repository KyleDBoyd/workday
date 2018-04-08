@testable import workday_solutionTests
import XCTest
import Hippolyte

class APITests: XCTestCase {

    override func setUp() {
        super.setUp()
        Hippolyte.shared.start()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        Hippolyte.shared.stop()
    }
    
    func testPing() {
        let urlString = Strings.API.baseURL + "/" + Strings.API.Routes.health
        let url = URL(string: urlString)!
        var stub = StubRequest(method: .GET, url: url)
        var stubResponse = StubResponse(statusCode: 200)
        let body = "".data(using: .utf8)!
        stubResponse.body = body
        stub.response = stubResponse
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Stubs network call")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            XCTAssertEqual(stubResponse.statusCode, httpResponse.statusCode)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetAllMedia() {
         let urlString = Strings.API.baseURL + "/" + Strings.API.Routes.media
        let url = URL(string: urlString)!
        var stub = StubRequest(method: .GET, url: url)
        var stubResponse = StubResponse(statusCode: 200)
        
        let body = self.getStub("getAllMedia")
        stubResponse.body = body
        stub.response = stubResponse
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Stubs network call")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            XCTAssertEqual(body, data)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMediaItem() {
        let urlString = Strings.API.baseURL + "/" + Strings.API.Routes.media + "/" + "be96621d-7b27-404d-96eb-68cb29a82222"
        let url = URL(string: urlString)!
        var stub = StubRequest(method: .GET, url: url)
        var stubResponse = StubResponse(statusCode: 200)
        
        let body = self.getStub("getMediaItem")
        stubResponse.body = body
        stub.response = stubResponse
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Stubs network call")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            XCTAssertEqual(stubResponse.statusCode, httpResponse.statusCode)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func getStub(_ fileName:String) -> Data {
        var data:Data = Data()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                XCTFail()
            }
        }
        return data

    }
}
