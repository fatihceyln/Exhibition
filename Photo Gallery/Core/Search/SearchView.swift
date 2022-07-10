//
//  SearchView.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 10.07.2022.
//

import SwiftUI

struct SearchView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            searchSection
            
            ScrollView {
                browseByCategory
                
                discoverSection
            }
            
        }
        .padding()
    }
    
    private var discoverSection: some View {
        VStack {
            Text("Discover")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(0..<10, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
    
    private var browseByCategory: some View {
        VStack(spacing: 0) {
            Text("Browse by Category")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 240, height: 150)
                    }
                }
            }
            .frame(height: 180)
        }
        .padding(.top)
    }
    
    private var searchSection: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Seach photos, collections, users", text: $text)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
