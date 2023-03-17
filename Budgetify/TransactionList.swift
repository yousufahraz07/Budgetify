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
            List{
                //Groups
                ForEach(Array(transactionListVM.groupTransactionMonth()),id: \.key){
                    month,transactions in
                    Section{
                        ForEach(transactions){transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header:{
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM : TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        NavigationView {
            TransactionList()
        }
        NavigationView {
            TransactionList()
                .preferredColorScheme(.dark)
            }
        .environmentObject(transactionListVM)
        }
       
    }

