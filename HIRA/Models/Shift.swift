//
//  Shift.swift
//  HIRA
//
//  Created by Debashis  on 19/01/18.
//  Copyright © 2018 Debashis . All rights reserved.
//

import UIKit
import Gloss
class Shift: Glossy {
    var id:Int?
    var name:String?
    var statusId:Int?
    var createdAt:Date
    
    required init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.statusId = "statusId" <~~ json
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        let date = dateFormatter.date (from: ("created_at" <~~ json)!)
        self.createdAt = date!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
        ])
    }
    
    

}
