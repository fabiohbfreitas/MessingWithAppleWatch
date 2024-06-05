//
//  SampleUserDefaultStorage.swift
//  MessingWithAppleWatch Watch App
//
//  Created by Fabio Freitas on 04/06/24.
//

import Foundation
import WidgetKit


final class SampleUserDefaultStorage {
    private let ud = UserDefaults(suiteName: "group.MessingWithAppleWatch.watchApp")
    
    private init() {
        
    }
    
    public static let shared: SampleUserDefaultStorage = .init()
    
    private static let testKey = "testttt2"
    
    func saveNumber(n: Int) {
        guard let ud else { return }
        ud.setValue(n, forKey: Self.testKey)
        WidgetCenter.shared.reloadTimelines(ofKind: "SampleWidget")
    }
    
    func fetchNumber() -> Int {
        guard let ud else { return 999 }
        return ud.integer(forKey: Self.testKey)
    }
}
