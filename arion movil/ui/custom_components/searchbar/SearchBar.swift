//
//  SearchBar.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import UIKit
import SwiftUI
struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if(searchText.isEmpty)
            {
                searchBar.resignFirstResponder()
                self.text = "000"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.text = searchText
                    }
            
            
        }
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.resignFirstResponder()
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            

        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.init(named: "background")
        searchBar.autocapitalizationType = .none
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
  
}

