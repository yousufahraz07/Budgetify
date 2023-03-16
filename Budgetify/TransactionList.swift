//
//  TransactionList.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListView
    
    var body: some View {
        VStack{
            
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionList()
        }
        NavigationView {
            TransactionList()
                .preferredColorScheme(.dark)
        }
    }
}
