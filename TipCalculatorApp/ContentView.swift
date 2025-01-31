//
//  Persistence.swift
//  TipCalculatorApp
//
//  Created by Yashwanth CV on 30/01/25.
//
import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0.0
    @State private var tipPercentage: Double = 15.0
    @State private var numberOfPeople: Double = 1.0
    @State private var showResults: Bool = false
    @State private var selectedCurrency: String = "USD"
    private let currencyOptions = ["USD" , "EUR" , "JPY"]
    
    private var tipAmount: Double {
        return (billAmount * tipPercentage) / 100
    }
    
    private var totalAmount: Double {
        return billAmount + tipAmount
    }
    
    private var amountPerPerson: Double {
        return totalAmount / max(numberOfPeople, 1)
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = selectedCurrency
        return formatter
    }

    var body: some View {
        VStack {
            Text("Modern Tip Calculator")
                .foregroundColor(.black)
                .font(.title3)
                .bold()
//                .padding()
            
            Text("Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
//            Spacer()
            
            Image(.currency)
                .resizable()
                .frame(width:70 ,height: 70)
                .scaledToFit()
                .padding(.all)
                .onTapGesture {
                    toggleCurrency()
                }
    
            VStack(alignment: .leading) {
                Text("Bill Amount: \(currencyFormatter.string(for: billAmount) ?? "$0.00")")
                    .foregroundColor(.purple)
                Slider(value: $billAmount, in: 0...500, step: 1)
                    .tint(.purple)
                    .padding(.bottom, 10)
                
                Text("Tip Percentage: \(Int(tipPercentage))%")
                    .foregroundColor(.teal)
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .tint(.teal)
                    .padding(.bottom, 10)
                
                Text("Number of People: \(Int(numberOfPeople))")
                    .foregroundColor(.orange)
                Slider(value: $numberOfPeople, in: 1...20, step: 1)
                    .tint(.orange)
            }
            .padding()
            
            if showResults {
                VStack {
                    Text("Tip Amount: \(currencyFormatter.string(for: tipAmount) ?? "$0.00")")
                    Text("Total Amount: \(currencyFormatter.string(for: totalAmount) ?? "$0.00")")
                    Text("Amount per Person: \(currencyFormatter.string(for: amountPerPerson) ?? "$0.00")")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
//                .shadow(radius: 5)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.3), radius: 10, x: -5, y: -5)
            }
            
            Button(action: {
                showResults.toggle()
            }) {
                Text(showResults ? "Hide Results" : "Calculate")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(showResults ? Color.red: Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: -5, y: -5)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
    func currencySymbol(for currencyCode: String) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = currencyCode
            return formatter.currencySymbol ?? "N/A"
        }
    
    
        private func toggleCurrency() {
            if let currentIndex = currencyOptions.firstIndex(of: selectedCurrency) {
                let nextIndex = (currentIndex + 1) % currencyOptions.count
                selectedCurrency = currencyOptions[nextIndex]
            }
        }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

}
