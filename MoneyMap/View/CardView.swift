//
//  CardView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/25/24.
//

import SwiftUI

struct CardView: View {
    var colors :[Color] = [ .orange, .mint,.purple,.blue,
                            ]
    @ObservedObject var vm : ViewModel
    @State var datenow = Date()
    @Binding  var selectedTab: Int
    @State private var showAlert = false
    @Environment(\.colorScheme) var colorScheme
    @Binding var showCard: Bool
    @State var isAdded : Bool = false
    @State var selectedCategory: TransactionType = .income
    @State private var animationAmount: CGFloat = 0.0
    @Namespace private var animation

    
    var body: some View {
        
        ZStack {
            Color("BgColor").ignoresSafeArea()
            
                
            
                VStack {
                    HStack {
                        Image(systemName: "mappin.and.ellipse.circle")
                            .foregroundStyle(.green.gradient)
                        
                            .font(.largeTitle)
                        Text("MoneyMap")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        
                        //                    }
                        
                        if vm.savedData.isEmpty {
                            NavigationLink {
                                AddDetailView(vm: vm, selectedTab: $selectedTab)
                            } label: {
                                Image(systemName: "plus.app.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }

                        } else {
                            Button {
                                showAlert = true
                            } label: {
                                Image(systemName: "minus.square.fill")
                                    .font(.largeTitle)
                                    .tint(.red)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Delete All Transactions"),
                                    message: Text("Are you sure you want to delete all transactions? This action cannot be undone."),
                                    primaryButton: .destructive(Text("Delete")) {
                                        withAnimation {
                                            vm.deleteAllTransactions()
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            
                        }
                        
                        }
                    .padding()
                        
                       
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(MeshGradient(width: 3, height: 3,
                                               points:[[0, 0], [0.5, 0], [1, 0],
                                                       [0, 0.5], [0.5, 0.5], [1, 0.5],
                                                       [0, 1], [0.5, 1], [1, 1]],
                                               colors: [.red, .purple, .indigo,
                                                        .orange, .cyan, .blue,
                                                        .yellow, .green, .mint]))
                            .shadow(radius: 5)
                        
                        
                        
                        
                        VStack {
                            HStack {
                                Text("MOHAMED FUAD")
                                    .foregroundStyle(.white.gradient.opacity(0.9))
                                    .font(.system(size: 20).bold().monospaced())
                                Spacer()
                                Toggle("", isOn: $showCard)
                                    .toggleStyle(.switch)
                                    .tint(.gray.opacity(0.85))
                            }
                            .padding()
                            
                            Spacer()
                            VStack(alignment:.leading) {
                                HStack {
                                    Text("Balance")
                                    
                                    Spacer()
                                }
                                if showCard {
                                    formatYen(vm.totalIncome - vm.totalExpense)
                                        .font(.title.bold())
                                }
                                
                                
                                
                            }
                            .padding()
                            
                            
                            HStack {
                                
                                Text("XXXX XXXX XXXX 4657")
                                    .padding(.leading)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                                
                                Image("visa")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(height: 20)
                                    .padding(30)
                            }
                            
                        }
                    }
                    
                    .foregroundColor(.white)
                    .frame(height: 220)
                    .padding()
                    
                    VStack {
                        VStack {
                            
                            
                            HStack(spacing:12) {
                                
                                formatYen(vm.totalIncome - vm.totalExpense)
                                    .font(.title.bold())
                                
                                Image(systemName: vm.totalExpense > vm.totalIncome ? "chart.line.downtrend.xyaxis":"chart.line.uptrend.xyaxis")
                                    .font(.title3)
                                    .foregroundStyle(.red)
                            }
                            
                            HStack(spacing:20) {
                                ForEach(TransactionType.allCases,id: \.rawValue){category in
                                    let symbolImage = category == .income ? "arrow.down":"arrow.up"
                                    let tint = category == .income ? Color.green : Color.red
                                    
                                    HStack(spacing:10) {
                                        Image(systemName: symbolImage)
                                            .font(.title3.bold())
                                            .foregroundStyle(tint)
                                            .frame(width: 35,height: 35)
                                            .background(
                                                Circle()
                                                    .fill(tint.opacity(0.25).gradient)
                                                
                                            )
                                        
                                        
                                        VStack(alignment: .leading,spacing: 4) {
                                            Text(category.rawValue)
                                                .font(.caption2)
                                                .foregroundStyle(.gray)
                                            
                                            formatYen(category == .income ? vm.totalIncome:vm.totalExpense)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                            
                                            
                                        }
                                        if category == .income {
                                            Spacer(minLength: 20)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        .foregroundStyle(colorScheme == .dark ? .white:.black)
                        .padding([.horizontal,.bottom],25)
                        .padding(.top, 25)
                        .frame(width: 360)
                        .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                        .cornerRadius(15)
                        .padding(10)
                        
                        
                        HStack(spacing:0) {
                            ForEach(TransactionType.allCases,id: \.rawValue) {category in
                                Text(category.rawValue)
                                
                                    .frame(width:170)
                                    .padding(.leading,1)
                                
                                //                        .padding(.horizontal)
                                    .padding(.vertical,13)
                                
                                    .background {
                                        if category == selectedCategory {
                                            Capsule()
                                                .fill(colorScheme == .dark ? .gray: .white)
                                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                        }
                                    }
                                    .contentShape(.capsule)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            selectedCategory = category
                                        }
                                    }
                            }
                            
                        }
                        
                        .frame(height: 45)
                        .background(colorScheme == .dark ? .gray.opacity(0.15):.gray.opacity(0.15))
                        .clipShape(.capsule)
                        
                        List {
                            ForEach(vm.savedData.filter { transaction in
                                if  selectedCategory == selectedCategory {
                                    return transaction.type == selectedCategory.rawValue}
                                return true}) { entity in
                                    customtransactionview(
                                        title: entity.title ?? "No detail",
                                        memo: entity.title ?? "none",
                                        date: entity.date ?? Date(),
                                        amount: entity.amount,
                                        trantype: entity.tranctype ?? "camera.metering.none", entity: entity
                                    )
                                    
                                    .onAppear {
                                        isAdded = true
                                    }
                                    .listRowBackground(colorScheme == .dark ? Color.gray.opacity(0.35) : Color.white)
                                   
                                }
                            
                            
//                                                    .padding(.horizontal)
                                .animation(.easeInOut, value: isAdded)
                        }
                        .listRowSpacing(5)
                        .scrollContentBackground(.hidden)
                        .listRowSeparator(.hidden)
                    
//                        .listRowInsets(EdgeInsets())
                        
                        .scrollContentBackground(.hidden)
                    
                        
                        
                       
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    //
                }
              
            
               
        }
        
        
        
    }
    
    
    
    
    
    @ViewBuilder
    func customtransactionview(title: String,memo:String,date:Date,amount:Double,trantype:String,entity:Transaction) -> some View {
        HStack {
            Image(systemName: trantype)
                .frame(width: 30,height: 30)
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(colorScheme == .dark ? .white:.black)
                .font(.title3)
                .padding()
                .symbolEffect(.breathe)
                .background(colorScheme == .dark ? .gray.opacity(0.15):Color.indigo.opacity(0.15))
                .cornerRadius(30)
            Divider()
                .foregroundStyle(colorScheme == .dark ? .red:.black)
            VStack(alignment:.leading,spacing: 3) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.subheadline)
                Text(memo)
                    .font(.caption2)
                    .foregroundStyle(colorScheme == .dark ? .white:.gray)
                Text(date.formatted(date: .numeric, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(colorScheme == .dark ? .white:.gray)
            }
            Spacer()
            Text(Double(amount), format: .currency(code: "JPY"))
        }
        .padding(.vertical, 14)
            .padding(.horizontal, 1)
            .frame(maxWidth: .infinity, maxHeight: 70)
            .background(colorScheme == .dark ? .gray.opacity(0) : .white)
            .cornerRadius(10)
        .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        withAnimation {
                            vm.deleteTransaction(entity)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
        
    }
  
       
    }




extension View {
    func formatYen(_ value: Double) -> some View {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return Text(formatter.string(from: NSNumber(value: value)) ?? "¥0.00")
    }
}


#Preview {
    CardView(vm: ViewModel(), selectedTab: .constant(2), showCard: .constant(true))
}
