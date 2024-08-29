import SwiftUI
import Charts
import SwiftData

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [Chartcategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct Chartcategory: Identifiable {
    let id: UUID = .init()
    var totalValue: Double
    var category: TransactionType
}

struct GraphView: View {
    @ObservedObject var vm: ViewModel
    @State private var chartGroups: [ChartGroup] = []

    var body: some View {
        LazyVStack(spacing: 10) {
            Chart {
                ForEach(chartGroups) { group in
                    ForEach(group.categories) { chart in
                        BarMark(
                            x: .value("Date", group.date, unit: .month),
                            y: .value("Total Value", chart.totalValue)
                        )
                        .foregroundStyle(by: .value("Category", chart.category.rawValue))
                        .cornerRadius(5)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month))
            }
            .chartYAxis {
                AxisMarks()
            }
            .padding()
            .onAppear {
                setupChartGroups()
            }
        }
        .padding()
    }

    // Function to setup chart groups based on ViewModel data
    private func setupChartGroups() {
        var groupedData: [Date: [Transaction]] = [:]

        for transaction in vm.savedData {
            let components = Calendar.current.dateComponents([.year, .month], from: transaction.date ?? Date())
            if let date = Calendar.current.date(from: components) {
                groupedData[date, default: []].append(transaction)
            }
        }

        chartGroups = groupedData.map { (date, transactions) in
            let totalIncome = transactions.filter { $0.type == TransactionType.income.rawValue }
                .reduce(0) { $0 + $1.amount }
            let totalExpense = transactions.filter { $0.type == TransactionType.expense.rawValue }
                .reduce(0) { $0 + $1.amount }

            let categories = [
                Chartcategory(totalValue: totalIncome, category: .income),
                Chartcategory(totalValue: totalExpense, category: .expense)
            ]

            return ChartGroup(date: date, categories: categories, totalIncome: totalIncome, totalExpense: totalExpense)
            
            
            
            
        }
    }
}

#Preview {
    GraphView(vm: ViewModel()) // Provide a sample ViewModel instance
}
