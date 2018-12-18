//
//  HIRAModelTests.swift
//  HIRATests
//
//  Created by Debashis  on 23/11/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import XCTest
import Gloss
class HIRAModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testThatUserModelInitializedWithJson(){
        let userJsonString:String = "{\"id\":\"1651\",\"first_name\":\"arpita\",\"last_name\":\"roy\",\"username\":\"ohiodriver\",\"email\":\"arpita@ewaycorp.com\",\"phone\":\"(124) 512-4512\",\"user_type\":\"2\",\"status\":\"1\",\"password_token\":\"a8ee26d3df9a84e70ead93e8192af3ec\",\"created_at\":\"2017-11-03 07:35:12\",\"updated_at\":\"2017-11-21 12:05:02\"}"
        var userJSON:JSON?
        var userModel:User?
        userJSON = convertToDictionary(text: userJsonString)
        userModel = User(json: userJSON!)
        XCTAssertEqual(userModel!.id, "id" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.firstName, "first_name" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.lastName, "last_name" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.userName, "username" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.email, "email" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.phone, "phone" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.userType, "user_type" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.status, "status" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.passwordToken, "password_token" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.createdAt, "created_at" <~~ userJSON!, "user model is not initialized as per json fed")
        XCTAssertEqual(userModel!.updatedAt, "updated_at" <~~ userJSON!, "user model is not initialized as per json fed")
    }
    func testThatUserModelDeserializes(){
        let userModelToTest:User = User(id: "1", firstName: "Joe", lastName: "B", userName: "joe", email: "joe@eway.com", phone: "852410", userType: "1", status: "1", passwordToken: "abcd", createdAt: "12-Nov-17", updatedAt: "12-Nov-17")
        let userModelToTestJson = userModelToTest.toJSON()
        XCTAssertEqual(userModelToTest.id, "id" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.firstName, "first_name" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.lastName, "last_name" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.userName, "username" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.email, "email" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.phone, "phone" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.userType, "user_type" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.status, "status" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.passwordToken, "password_token" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.createdAt, "created_at" <~~ userModelToTestJson!, "User model is not deserialized")
        XCTAssertEqual(userModelToTest.updatedAt, "updated_at" <~~ userModelToTestJson!, "User model is not deserialized")
    }
    func testThatUserModelSerializesFromArray(){
        let userJsonString:String = "[{\"id\":\"1651\",\"first_name\":\"arpita\",\"last_name\":\"roy\",\"username\":\"ohiodriver\",\"email\":\"arpita@ewaycorp.com\",\"phone\":\"(124) 512-4512\",\"user_type\":\"2\",\"status\":\"1\",\"password_token\":\"a8ee26d3df9a84e70ead93e8192af3ec\",\"created_at\":\"2017-11-03 07:35:12\",\"updated_at\":\"2017-11-21 12:05:02\"},{\"id\":\"1652\",\"first_name\":\"Joe\",\"last_name\":\"B\",\"username\":\"ohiodriver\",\"email\":\"joe@ewaycorp.com\",\"phone\":\"(124) 512-4512\",\"user_type\":\"2\",\"status\":\"1\",\"password_token\":\"a8ee26d3df9a84e70ead93e8192af3ec\",\"created_at\":\"2017-11-03 07:35:12\",\"updated_at\":\"2017-11-21 12:05:02\"}]"
        var userJSON:[JSON]?
        userJSON = convertToDictionaryArray(text: userJsonString)
        let userModels:[User] = [User].from(jsonArray: userJSON!)!
        for (index,userModel) in userModels.enumerated() {
            XCTAssertEqual(userModel.id, "id" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.firstName, "first_name" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.lastName, "last_name" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.userName, "username" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.email, "email" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.phone, "phone" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.userType, "user_type" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.status, "status" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.passwordToken, "password_token" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.createdAt, "created_at" <~~ userJSON![index], "user model is not initialized as per json fed")
            XCTAssertEqual(userModel.updatedAt, "updated_at" <~~ userJSON![index], "user model is not initialized as per json fed")
        }
    }
    func testThatUserModelDeserializesFromArray(){
        let userModelsToTest:[User] = [
            User(id: "1", firstName: "Joe", lastName: "B", userName: "joe", email: "joe@eway.com", phone: "852410", userType: "1", status: "1", passwordToken: "abcd", createdAt: "12-Nov-17", updatedAt: "12-Nov-17"),
            User(id: "2", firstName: "Jiko", lastName: "B", userName: "jiko", email: "jiko@eway.com", phone: "852410", userType: "1", status: "1", passwordToken: "abcd", createdAt: "12-Nov-17", updatedAt: "12-Nov-17")
        ]
        let userModelsToTestJsons = userModelsToTest.toJSONArray()!
        for (index,userModelToTestJson) in userModelsToTestJsons.enumerated() {
            XCTAssertEqual(userModelsToTest[index].id, "id" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].firstName, "first_name" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].lastName, "last_name" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].userName, "username" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].email, "email" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].phone, "phone" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].userType, "user_type" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].status, "status" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].passwordToken, "password_token" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].createdAt, "created_at" <~~ userModelToTestJson, "User model is not deserialized")
            XCTAssertEqual(userModelsToTest[index].updatedAt, "updated_at" <~~ userModelToTestJson, "User model is not deserialized")
        }
        
    }
    func testThatHIRAErrorModelInitializedWithJson(){
        
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func convertToDictionaryArray(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
