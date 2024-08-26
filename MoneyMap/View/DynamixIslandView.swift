//
//  DynamixIslandView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/25/24.
//

import SwiftUI

enum type: Hashable,CaseIterable {
    case income, expense
    var transactiontype:String {
        switch self {
        case .income:
            return "dollarsign.circle.fill"
        case .expense:
            return "creditcard.fill"
        }
    }
    
}

struct DynamicIslandView: View {
    
    @ObservedObject var vm : ViewModel
    @State private var isTapped: Bool = false
    @State var currenttype: String = "income"
    @State var memo: String = ""
    @State var amount: String = ""
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            
            VStack(alignment:.center) {
                Text("add transaction".uppercased())
                    .font(.caption)
                HStack(alignment:.center) {
                    
                    TextField("$0", text: $amount)
                        .foregroundStyle(.black)
                        .keyboardType(.decimalPad)
                        .frame(width: 70)
                        .font(.largeTitle)
                        .padding()
//                        .padding(.leading,10)
//                        .textFieldStyle(.roundedBorder)
                }
               
                HStack {
                    Picker("Data Selection", selection: $currenttype) {
                        ForEach(type.allCases,id: \.self) { trantype in
                            Image(systemName: trantype.transactiontype)
                                .tag(trantype.transactiontype)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                }
                HStack(spacing: 10) {
                    Image(systemName: "note.text")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(.breathe, value: memo)
//                        .padding(.leading)
                    TextField("Note", text: $memo)
                        .foregroundColor(.blue)
                }
                .padding()

                Button("Save") {
                    withAnimation {
                        vm.addTransaction(title: memo, amount: Double(amount) ?? 0.0, type: currenttype)
                        memo = ""
                        amount = ""
                        selectedTab = 1
                        
                    }
                    
                    
                }
                .fontWeight(.semibold)
                .frame(width: 150)
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .cornerRadius(25)
                .padding()
                
                
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(25)
            .padding()
            .ignoresSafeArea()
        }
    }
}

#Preview {
    DynamicIslandView(vm: ViewModel(), selectedTab: .constant(1))
}
