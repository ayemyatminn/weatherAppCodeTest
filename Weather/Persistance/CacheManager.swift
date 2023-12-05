//
//  CacheManager.swift
//  Weather
//
//  Created by Aye Myat Minn on 05/12/2023.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()

    private let userDefaults = UserDefaults.standard
    private let resultKey = "cachedResult"

    func cacheResult(_ result: Result) {
        do {
            let encodedData = try JSONEncoder().encode(result)
            userDefaults.set(encodedData, forKey: resultKey)
        } catch {
            print("Error encoding result: \(error.localizedDescription)")
        }
    }

    func getCachedResult() -> Result? {
        if let encodedData = userDefaults.data(forKey: resultKey) {
            do {
                let result = try JSONDecoder().decode(Result.self, from: encodedData)
                return result
            } catch {
                print("Error decoding result: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }
}
