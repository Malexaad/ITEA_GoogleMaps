//
//  UserInfo.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/20/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import UIKit

class Coordinates {
    var longtitude : Double
    var latitude : Double
    
    init(longtitude : Double, latitude : Double) {
        self.latitude = latitude
        self.longtitude = longtitude
    }
}

class UserInfo {
    var userImage : String
    var userName : String
    var userSurname : String
    var userAge : Int
    var userAdress : String
    var userPhone : String
    var userEmail : String
    var coordinates : Coordinates
    init(userImage : String, userName : String, userSurname : String, userAge : Int, userAdress : String, userPhone : String, userEmail : String, coordinates : Coordinates) {
        self.userImage = userImage
        self.userName = userName
        self.userSurname = userSurname
        self.userAge = userAge
        self.userAdress = userAdress
        self.userPhone = userPhone
        self.coordinates = coordinates
        self.userEmail = userEmail
    }
}
