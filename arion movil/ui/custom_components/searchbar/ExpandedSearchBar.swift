//
//  ExpandedSearchBar.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ExpandedSearchBar: View {
    @Binding var show:Bool
    @Binding var txt:String
    var placeholder: String
    var body: some View {
        HStack{
          
            Spacer(minLength: 0)
            
            HStack{
                
                if self.show{
                    
                    Image("search").padding(.horizontal, 8)
                    
                    TextField(placeholder, text: self.$txt)
                    
                    Button(action: {
                        
                        withAnimation {
                            
                            self.txt = ""
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                    .padding(.horizontal, 8)
                    
                }
                
                else{
                    
                    Button(action: {
                        
                        withAnimation {
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        Image("search").foregroundColor(.black).padding(10)
                        
                    }
                }
            }
            .padding(self.show ? 10 : 0)
            .background(Color("searcher"))
            .cornerRadius(20)
        }
    }
}

struct ExpandedSearchBar_Previews: PreviewProvider {
    
    struct BindingTestHolder: View {
           @State var testItem:String = ""
        @State var testIBool:Bool = false
           var body: some View {
            ExpandedSearchBar(show:$testIBool,txt: $testItem,placeholder:"Buscar Restaurante")
           }
       }
    @State  var searchText : String = ""
    static var previews: some View {
       
        BindingTestHolder()
            .preferredColorScheme(.dark)
        
    }
}
