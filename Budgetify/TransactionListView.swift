//
//  TransactionListView.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import Foundation
import Combine

typealias TransactionGroup = [String : [Transaction]]
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
}
