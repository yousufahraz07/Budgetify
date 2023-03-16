//
//  RecentTransaction.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import SwiftUI

struct RecentTransaction: View {
    @EnvironmentObject var transactionListVM : TransactionListView
    var body: some View {
        VStack{
            HStack{
                //Header
                Text("Recent Transactions")
                    .bold()
                Spacer()
                //Navigation
                NavigationLink{
                    
                } label : {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
                .padding(.top)
            
            //Recent Transaction List
ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
    
                }
            }
            .padding()
            .backgroundStyle(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .shadow(color: Color.primary.opacity(0.2),radius: 10, x: 0, y: 5)
        }
    }
    
struct RecentTransaction_Previews : PreviewProvider{
    static let transactionListVM : TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
            RecentTransaction()
            RecentTransaction()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
