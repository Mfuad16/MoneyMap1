        
        //  AddDetailView.swift
        //  MoneyMap
        //
        //  Created by Mohamed Fuad on 8/28/24.
        //

        import SwiftUI

        struct AddDetailView: View {
            
            @ObservedObject var vm: ViewModel
            @Environment(\.colorScheme) var colorScheme
            @Environment(\.dismiss) var dismiss
            
            @State var currentfield: String = ""
            @State var currentfield1: String = ""
            @State var currentfield2: String = ""
            @State var currentdate: Date = Date()
            
            @State var tranctype: IncomeSubcategory = .salary
            @State var category : TransactionType = .income
            @State var currentSel: Bool = false
            
            @FocusState var isFocused: Bool
            @Binding var selectedTab: Int
            
            
            var body: some View {
                NavigationStack {
                    ZStack {
                        Color("BgColor").ignoresSafeArea()
                           
                        VStack() {
                            
                            ScrollView() {
                                HStack {
                                    Text("Preview")
                                        .font(.title2.bold())
                                        .foregroundStyle(colorScheme == .dark ? .white:.black)
                                    Spacer()
                                }
                                
                                
                                customtransactionview(title: currentfield, memo: currentfield1, date: currentdate, amount: Double(currentfield2) ?? 0.0, trantype: tranctype.transactiontypeicon)
                                    .foregroundStyle(colorScheme == .dark ? .white:.black)
                                    .padding(.bottom,10)
                                
                                
                                customSection("Title", "Magic Keyboard", value: $currentfield)
                                    .padding(.bottom,10)
                                   
                                customSection("Remarks", "Apple Product", value: $currentfield1)
                                    .padding(.bottom,10)
                                
                                customSection1("Amount & category", "0", value: $currentSel,value1: $currentfield2)
                                 
                                    categoryGrid()
                                    .padding(.top,5)
                                
                                
                                DatePicker("Select a Date",selection: $currentdate,displayedComponents: [.date])
                                    .datePickerStyle(.graphical)
                                    .padding()
                                    .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                                    .cornerRadius(10)
                                    .navigationTitle("Add Transaction")
                                    .padding(.vertical,10)
                                
                                Button("Save") {
                                    vm.addTransaction(title: currentfield, amount: Double(currentfield2) ?? 0.0, type: category.rawValue, date: currentdate, tranctype: tranctype.transactiontypeicon)
                                    currentfield = ""
                                    currentfield1 = ""
                                    currentfield2 = ""
                                    currentdate = Date()
                                    selectedTab = 0
                                    dismiss()
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.85)
                                .foregroundColor(.white)
                                .padding()
                                .background(colorScheme == .dark ? .blue:.black)
                                .cornerRadius(10)
                                .padding(.vertical,10)
                                
                            }
                            .scrollIndicators(.hidden)
                            
                        }
                        .padding(15)
                        
                    }
                }
            }
            
            
            
            @ViewBuilder
            func customSection(_ title:String,_ hint:String,value: Binding<String>) -> some View {
                VStack(alignment: .leading,spacing: 10) {
                    Text(title)
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? .white:.black)
                        
                    TextField(hint,text: value)
                        .padding(.horizontal,15)
                        .padding(.vertical,12)
                        .foregroundStyle(colorScheme == .dark ? .white:.black)
                        .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                        .cornerRadius(10)
                }
            }
            
            
            @ViewBuilder
            func customSection1(_ title:String,_ hint:String,value: Binding<Bool>,value1: Binding<String>) -> some View {
                HStack {
                    VStack(alignment: .leading,spacing: 10) {
                        Text(title)
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? .white:.gray)
                            
                        TextField(hint,text: value1)
                            .frame(height: 25)
                            .padding(.horizontal,15)
                            .padding(.vertical,11)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                isFocused = true
                            }
                            .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                            .cornerRadius(10)
                            .focused($isFocused)
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        isFocused = false
                                    }
                                }
                            }
                    }

                    categorycheckbox()
                        .padding(.top,24)
                }
            }
            
            @ViewBuilder
            func categorycheckbox() -> some View {
                VStack {
                    HStack(spacing: 3) {
                        ForEach(TransactionType.allCases, id: \.self) { categoryItem in
                            ZStack {
                                Image(systemName: "circle")
                                    .font(.title3)
                                    .foregroundColor(.red)
                                
                                if self.category == categoryItem {
                                    Image(systemName: "circle.fill")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                            
                            
                            Text(categoryItem.rawValue)
                                .fontWeight(.semibold)
                                .font(.caption)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.category = categoryItem
                                }
                                
                        }
                    }
                    .frame(width: 180, height: 48)
                    .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                    .cornerRadius(10)
                }
            }
            
            @ViewBuilder
            func categoryGrid() -> some View {
                VStack(alignment: .leading) {
                    Text("Category")
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? .white:.gray)
                        .padding(.horizontal,1)
                        .padding(.vertical,10)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                        ForEach(IncomeSubcategory.allCases, id: \.self) { categoryItem in
                            if self.category == .income {
                                if categoryItem.rawValue == "Salary" || categoryItem.rawValue == "Extra Money" || categoryItem.rawValue == "Pocket Money" {
                                    
                                        VStack {
                                            ZStack {
                                                Image(systemName: "circle")
                                                    .font(.title3)
                                                    .foregroundColor(.red)
                                                
                                                
                                                if self.tranctype == categoryItem {
                                                    Image(systemName: "circle.fill")
                                                        .font(.caption)
                                                        .symbolEffect(.bounce)
                                                        .foregroundColor(.red)
                                                }
                                            }
                                            .onTapGesture {
                                                self.tranctype = categoryItem
                                                print(tranctype)
                                            }
                                            
                                          
                                                Text(categoryItem.rawValue)
                                                    .fontWeight(.semibold)
                                                    .font(.caption)
                                        }
                            }
                            }
                            else {
                                if !["Salary", "Extra Money", "Pocket Money"].contains(categoryItem.rawValue) {
                                    VStack {
                                        ZStack {
                                            Image(systemName: "circle")
                                                .font(.title3)
                                                .foregroundColor(.red)
                                            
                                            if self.tranctype == categoryItem {
                                                Image(systemName: "circle.fill")
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        Text(categoryItem.rawValue)
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                self.tranctype = categoryItem
                                                print(tranctype)
                                            }
                                    }
                                    .frame(maxWidth: .infinity)
                            }
                                }
                            }
                        }
                    .padding()
                    .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                    .cornerRadius(10)
                    }
                }
                
           
            @ViewBuilder
            func customtransactionview(title: String,memo:String,date:Date,amount:Double,trantype:String) -> some View {
                
                
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
                .frame(width: .infinity)
                .padding()
                .background(colorScheme == .dark ? .gray.opacity(0.15):.white)
                .cornerRadius(10)
                
            }
            
        }


        #Preview {
            AddDetailView(vm: ViewModel(), selectedTab: .constant(2))
        }
