//
//  AppUserDefault.swift
//  SpaceX-Dashboard
//
//  Created by iOS Dev on 02/08/21.
//

import Foundation

enum AppUserDefaults {

        enum Key: String {
            // keys for registered user dict
            case username
            case userpassword
            /// Key to manage total user in app, this will help in generating userId
            case appuserCount
            /// Key to manage all user's userID
            case appUserIds
            /// Key to get current logged in username
            case loggedInUserName
        }
}
    

extension AppUserDefaults {

    static func value(forKey key: Key, file: String = #file, line: Int = #line, function: String = #function) -> JSON {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {

            fatalError("No Value Found in UserDefaults\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }

        return JSON(value)
    }

    static func value<T>(forKey key: Key, fallBackValue: T, file: String = #file,
                         line: Int = #line, function: String = #function) -> JSON {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {

            print("No Value Found in UserDefaults\nFile : \(file) \nFunction : \(function)")
            return JSON(fallBackValue)
        }

        return JSON(value)
    }

    static func save(value: Any, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func removeValue(forKey key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func removeAllValues() {
        let appDomain = Bundle.main.bundleIdentifier ?? ""
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }
    static func saveLoggedInUserData(username: String) {
        AppUserDefaults.save(value: username, forKey: .loggedInUserName)
    }
    static func removeLoggedInUserData() {
        AppUserDefaults.removeValue(forKey: .loggedInUserName)
    }
    
    
    /// To save data in to userdefault, also it updates user count.
    /// So next time when we generate userID ,it shows appropriate
    /// - Parameters:
    ///   - username: usernmae to be saved
    ///   - password: password to be saved
    static func saveSignupUserData(username: String, password: String) {
        let userID = generateUniqueID()
        let dict = [AppUserDefaults.Key.username.rawValue:username,
                    AppUserDefaults.Key.userpassword.rawValue:password]
        
        UserDefaults.standard.set(dict, forKey: userID)
        UserDefaults.standard.synchronize()
        print("data saved")
        print("=====")
        print("username: \(username) password: \(password) userId:\(userID)")
        // also add userID
        self.insertUserID(userID: userID)
    }
    
    static func checkUserNameExist(username: String) -> Bool {
        let allUserIDs = getAllUserId()
        for userID in allUserIDs {
            let (dbUsername,_) = self.getUserDataForUseID(userID: userID)
            if dbUsername == username {
                return true
            }
        }
        return false
    }
    
    static func checkValidUser(username: String, password: String) -> Bool {
        let allUserIDs = getAllUserId()
        for userID in allUserIDs {
            let (dbUsername,dbPassword) = self.getUserDataForUseID(userID: userID)
            print(dbUsername)
            print(dbPassword)
            if dbUsername == username && dbPassword == password {
                return true
            }
        }
        return false
    }
    static func getUserDataForUseID(userID: String) -> (String, String) {
        
        let dict = UserDefaults.standard.dictionary(forKey: userID)
        let usernameKey = AppUserDefaults.Key.username.rawValue
        let passworKey = AppUserDefaults.Key.userpassword.rawValue
        if let dict = dict {
            if dict.keys.contains(usernameKey) && dict.keys.contains(passworKey) {
                let userName = dict[usernameKey] as! String
                let password = dict[passworKey] as! String
                return (userName, password)
                
            } else {
                print("No value found for userId  \(userID)")
                return ("","")
            }
        } else {
            print("No value found for userId  \(userID)")
            return ("","")
        }
    }
    
    /// Insert userID
    /// - Parameter userID: userID to be saved
    static func insertUserID(userID: String) {
        var allUserIDs = getAllUserId()
        allUserIDs.append(userID)
        AppUserDefaults.save(value: allUserIDs, forKey: .appUserIds)
        // grab count from userID (user1 - "user" + appcount)
        var userIdComponent = userID.components(separatedBy: "user")
        if userIdComponent.count == 2 {
            let appCount = userIdComponent[1]
            AppUserDefaults.save(value: appCount, forKey: .appuserCount)
        }
    }
    
    static func getAllUserId() -> [String] {
        let arrStrings = AppUserDefaults.value(forKey: .appUserIds,fallBackValue: [String]()).arrayValue
        var stringArray = [String]()
        for obj in arrStrings {
            stringArray.append(obj.stringValue)
        }
        return stringArray
    }
    static func generateUniqueID() -> String {
        var totalCount = AppUserDefaults.value(forKey: .appuserCount, fallBackValue: 0).intValue
        totalCount = totalCount + 1
        let userID = "user\(totalCount)"
        return userID
    }
}
