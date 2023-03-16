//
//  PreviewData.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import Foundation

var transactionPreviewData = Transaction(id:1, date: "03/16/2023", institution: "UW", account: "Visa UW", merchant: "Apple" , amount: 7.99 , type: "debit", categoryID: 801, category: "Software", isPending: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
