//
//  UserModel.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct User {
    var fullName : String!
    var description : String!
    var image: String!
    var imageBig: String!
}


class UserModel {
    static let sharedInstance : UserModel = UserModel()
    
    let nameOfCities : [Int: String] = [282: "Minsk", 281 : "Brest", 392: "Gomel"]
    
    private init() {}
    
    private var users : [User]? = nil
    
    func getUsers() -> [User] {
        if (users == nil) {
            reloadData();
        }
        return users!
    }
    
    func reloadData() {
        users = [User]()
        
        let path = Bundle.main.path(forResource: "users", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        let json = JSON(data: jsonData! as Data)
        
        for (_,subJson):(String, JSON) in json["response"]["users"] {
            var tmpUser = User()
            
            tmpUser.fullName = subJson["last_name"].string! + " " + subJson["first_name"].string!
            tmpUser.image = subJson["photo"].string!
            if let imageBig = subJson["photo_200"].string {
                tmpUser.imageBig = imageBig
            }
            tmpUser.description = ""
            if let city = subJson["city"].int {
                if nameOfCities.keys.contains(city) {
                    tmpUser.description = tmpUser.description + "City: " + nameOfCities[city]! + "\n"
                }
            }
            if let university = subJson["universities"][0]["name"].string {
                tmpUser.description = tmpUser.description + "University: " + university + "\n"
            }
            if let faculty = subJson["universities"][0]["faculty_name"].string {
                tmpUser.description = tmpUser.description + "Faculty: " + faculty + "\n"
            }
            if let speciality = subJson["universities"][0]["chair_name"].string {
                tmpUser.description = tmpUser.description + "Speciality: " + speciality + "\n"
            }
            
            users?.append(tmpUser)
        }
    }
}
