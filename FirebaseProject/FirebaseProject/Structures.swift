//
//  Structures.swift
//  FirebaseProject
//
//  Created by Archit Joshi on 25/07/22.
//

import Foundation


struct MyUser{
    var photoURL: String
    var displayName: String
    var uid: String
    var email: String
}

struct RequestBody: Codable { // client to API
    var token: String
    var fcmToke: String
    var appName: String
    var platform: String
    var modelName: String?
    var osVersion: String?
    var appVersion: String?
    var deviceId: String?
    var email: String
    var password: String
}



struct ResponseBody: Codable { // API to client
    let customToken: String
    let userInfo: UserInfo
    let isAllDataAvailable, isProfileCompleted: Bool
}

struct UserInfo: Codable {
    let id: Int
    let email, phone, name, emailVerifiedAt: String
    let phoneVerifiedAt: String
    let showSkipPhonePopup: Bool
    let showSkipPhonePopupAfterTime: String?
    let selfInterestedIndustries: [SelfInterestedIndustry]
    let settings: Settings
    let rating: String?
    let isSuspended: Bool
    let gender, dateOfBirth, inviteCode: String
    let skipPhone: Bool
    let profileImageID: Int
    let about, headline, currentPosition, lookingFor: String
    let isAllDataAvailable, isProfileCompleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, phone, name, emailVerifiedAt, phoneVerifiedAt, showSkipPhonePopup, showSkipPhonePopupAfterTime, selfInterestedIndustries, settings, rating, isSuspended, gender, dateOfBirth, inviteCode, skipPhone
        case profileImageID = "profileImageId"
        case about, headline, currentPosition, lookingFor, isAllDataAvailable, isProfileCompleted
    }
}

struct SelfInterestedIndustry: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let normalImageID: Int
    let category: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case normalImageID = "normalImageId"
        case category
    }
}


struct Settings: Codable {
    let newConnectNotifications, newMessageNotifications: Bool
    let notificationsTone: String
    let vibrate: Bool
    let lastSeenVisibleTo, profilePhotoVisibleTo: String
    let blockedContacts: String?
    let totalBlockedContacts: Int
}
