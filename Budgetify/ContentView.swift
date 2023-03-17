//
//  ContentView.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM : TransactionListView
    var demo : [Double] = [1,2,3,4,5]
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing : 24){
                    //Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //Chart
                    let data = transactionListVM.groupTransactions()
                    
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView{
                            VStack{
                                ChartLabel(totalExpenses.formatted(.currency(code: "CAD")),type :.title, format: "$%.02f")
                                LineChart()
                            }
                            .backgroundStyle(Color.systemBackground)
                        }
                            .data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4),Color.icon)))
                            .frame(height: 300)
                    }
                }
                //Transaction List
                RecentTransaction()
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //Notification Icon
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM : TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
