//
//  User.swift
//  HIRA
//
//  Created by Debashis  on 23/11/17.
//  Copyright © 2017 Debashis . All rights reserved.
//
// "user_details":{"id":"1651","first_name":"arpita","last_name":"roy","username":"ohiodriver","email":"arpita@ewaycorp.com","phone":"(124) 512-4512","user_type":"2","status":"1","password_token":"a8ee26d3df9a84e70ead93e8192af3ec","created_at":"2017-11-03 07:35:12","updated_at":"2017-11-21 12:05:02"}
import UIKit
import Gloss
class User:Glossy {
    var id:Int
    var firstName:String?
    var lastName:String?
    var userName:String?
    var email:String?
    var phone:String?
    var userType:String?
    var status:String?
    var passwordToken:String?
    var createdAt:String?
    var updatedAt:String?
    init(id:Int,firstName:String,lastName:String,userName:String,email:String,phone:String,userType:String,status:String,passwordToken:String,createdAt:String,updatedAt:String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.userType = userType
        self.email = email
        self.phone = phone
        self.status = status
        self.passwordToken = passwordToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    required init(json:JSON) {
        self.id = ("id" <~~ json)!
        self.firstName = "first_name" <~~ json
        self.lastName = "last_name" <~~ json
        self.userName = "username" <~~ json
        self.email = "email" <~~ json
        self.phone = "phone" <~~ json
        self.userType = "user_type" <~~ json
        self.status = "status" <~~ json
        self.passwordToken = "password_token" <~~ json
        self.createdAt = "created_at" <~~ json
        self.updatedAt = "updated_at" <~~ json
    }
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "first_name" ~~> self.firstName,
            "last_name" ~~> self.lastName,
            "username" ~~> self.userName,
            "email" ~~> self.email,
            "phone" ~~> self.phone,
            "user_type" ~~> self.userType,
            "status" ~~> self.status,
            "password_token" ~~> self.passwordToken,
            "created_at" ~~> self.createdAt,
            "updated_at" ~~> self.updatedAt
        ])
    }
}
