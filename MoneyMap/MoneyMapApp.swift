//
//  MoneyMapApp.swift
//  MoneyMap
//
//  Created by Mohamed Fuad on 8/26/24.
//

import SwiftUI

@main
struct MoneyMapApp: App {
   

    var body: some Scene {
        WindowGroup {
            TabbarView(vm: ViewModel())
        }
    }
}
