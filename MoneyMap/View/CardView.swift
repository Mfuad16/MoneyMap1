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
    
    var body: some View {
        
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 25)
                
                
                    .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .stroke(.blue, style: .init(lineWidth: 1))
                
                    .frame(width: 300,height: 200)
                    .padding(.top,10)
                
                VStack {
                    ForEach(vm.savedData) { entity in
                        Text(entity.title ?? "None")
                        
                    }
                }
                
                Spacer()
            }
            
               
        }
    }
}


struct MeshGradienView: View {
    var body: some View {
        Text("ss")
    }
}

#Preview {
    CardView(vm: ViewModel())
}
