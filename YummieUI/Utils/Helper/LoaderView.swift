//
//  LoaderView.swift
//  YummieUI
//


import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ProgressView()
            
            Text("Loading...")
                .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

