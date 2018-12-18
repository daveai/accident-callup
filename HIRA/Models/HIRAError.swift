//
//  Error.swift
//  HIRA
//
//  Created by Debashis  on 19/01/18.
//  Copyright © 2018 Debashis . All rights reserved.
//
import UIKit
import Gloss
class HIRAError:Glossy {
    var message:String?
    var status:Int?
    init(message:String, status:Int) {
        self.message = message
        self.status = status
    }
    required init(json:JSON) {
        self.message = "message" <~~ json
        self.status = "status" <~~ json
    }
    func toJSON() -> JSON? {
        return jsonify([
            "message" ~~> self.message,
            "status" ~~> self.status
        ])
    }
}
