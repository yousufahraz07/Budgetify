//
//  TransactionRow.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow : View {
    var transaction : Transaction
    
    var body : some View{
        HStack(spacing:20){
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon),fontsize: 24, color: Color.icon)
                }
            VStack(alignment: .leading,spacing: 6){
                //Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //Info
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //Date
                Text(transaction.dateParsed,format : .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            //Transaction 
            Text(transaction.signedAmount, format : .currency(code: "CAD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top,.bottom],8)
    }
}
struct TransactionRow_Preview : PreviewProvider{
    
    
    static  var previews: some View{
        Group {
        TransactionRow(transaction: transactionPreviewData)
        TransactionRow(transaction: transactionPreviewData)
            .preferredColorScheme(.dark)
    }
}
}
