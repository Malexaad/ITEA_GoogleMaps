//
//  UserInfoManager.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/20/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import UIKit

class UserInfoManager {
    var userList = [UserInfo]()
    
    func getUserList() -> [UserInfo] {
        userList.append(UserInfo(userImage: "Alex", userName: "Алексей", userSurname: "Марфутін", userAge: 25, userAdress: "вул. Миколи Соловцова", userPhone: "+380666817073", userEmail: "alexmarfutin@gmail.com", coordinates: Coordinates(longtitude:  30.5573606, latitude: 50.4052213)))
        userList.append(UserInfo(userImage: "Lilia", userName: "Лілія", userSurname: "Несіна", userAge: 22, userAdress: "вул. Металістів 8", userPhone: "+380997792763", userEmail: "someemail@example.com", coordinates: Coordinates(longtitude: 30.4502351, latitude: 50.449179)))
        userList.append(UserInfo(userImage: "Viacheslav", userName: "Вячеслав", userSurname: "Савіцький", userAge: 20, userAdress: "вул. Лобановського 6а", userPhone: "+380951853085", userEmail: "someemail@example.com", coordinates: Coordinates(longtitude: 30.4653832, latitude: 50.4225651)))
        userList.append(UserInfo(userImage: "Tolik", userName: "Толік", userSurname: "Гордієнко", userAge: 28, userAdress: "вул. Приозерна 2а", userPhone: "+380939817010", userEmail: "someemail@example.com", coordinates: Coordinates(longtitude: 30.5205583, latitude: 50.4927112)))
        userList.append(UserInfo(userImage: "Yarik", userName: "Ярослав", userSurname: "Павлюк", userAge: 26, userAdress: "вул. Вацлава Гавела 9а", userPhone: "+390505584120", userEmail: "someemail@example.com", coordinates: Coordinates(longtitude: 30.4255692, latitude: 50.4457899)))
    return userList
    }
}
