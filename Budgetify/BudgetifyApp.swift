//
//  BudgetifyApp.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import SwiftUI

@main
struct BudgetifyApp: App {
    @StateObject var transactionListVM = TransactionListView()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
