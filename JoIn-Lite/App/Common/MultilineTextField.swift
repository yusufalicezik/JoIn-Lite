//
//  MultilineTextField.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import UIKit

struct MultilineTextField: UIViewRepresentable {

    @Binding var text: String
    
    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = true
        textView.isEditable = true
        textView.text = "Bir şeyler yaz"
        textView.isUserInteractionEnabled = true
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .gray
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField
        
        init(parent: MultilineTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

//#Preview {
//    MultilineTextField(text: .constant(""))
//}
