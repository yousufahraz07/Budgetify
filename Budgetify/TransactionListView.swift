//
//  TransactionListView.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String , [Transaction]>
typealias TransactionPrefixSum = [(String,Double)]
final class TransactionListView : ObservableObject{
    @Published var transactions : [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        guard let url = URL(string: "") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{(data,response)-> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error fetching transactions",error.localizedDescription)
                case .finished:
                    print("Successfully fetched")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionMonth()-> TransactionGroup{
        guard !transactions.isEmpty else { return[:] }
        
        let groupedTransactions  = TransactionGroup(grouping: transactions) {$0.month}
        return groupedTransactions
    }
    
    func groupTransactions() -> TransactionPrefixSum{
        guard !transactions.isEmpty else { return [] }
        
        let today = "03/16/2023".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        var sum: Double = .zero
        var cSum = TransactionPrefixSum()
        
        for date in stride(from : dateInterval.start, to: today, by:60*60*24){
            let daily = transactions.filter{$0.dateParsed == date && $0.isExpense}
            let total = daily.reduce(0){$0-$1.signedAmount}
            
            sum += total
            sum = sum.rounded2()
            cSum.append((date.formatted(),sum))

        }
        return cSum
    }
}
