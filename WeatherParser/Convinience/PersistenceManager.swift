//
//  PersistenceManager.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* This class oversees to save data into userdefaults and gives it back when asked as a array*/
final class PersistenceManager {
    
    static let sharedInstance = PersistenceManager()
    
    func saveHistory(history: SearchHistory) {
        //retrieve saved array
        var modifiedHistory = [SearchHistory]()
        if let savedArrayData = UserDefaults.standard.data(forKey: "savedHistory"), let arrSearchHistory = NSKeyedUnarchiver.unarchiveObject(with: savedArrayData) as? [SearchHistory] {
            modifiedHistory.append(contentsOf: arrSearchHistory)
            //update saved array
            modifiedHistory.append(history)
        } else {
            //update saved array
            modifiedHistory.append(history)
        }
        
        //save modified array
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: modifiedHistory)
        UserDefaults.standard.set(archivedData, forKey: "savedHistory")
    }
    
    func getAllSavedHistory() -> [SearchHistory]? {
        if let savedArrayData = UserDefaults.standard.data(forKey: "savedHistory"), let arrSearchHistory = NSKeyedUnarchiver.unarchiveObject(with: savedArrayData) as? [SearchHistory] {
            return arrSearchHistory
        }
        return nil
    }
}
