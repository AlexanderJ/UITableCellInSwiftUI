//
//  FormEditField.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 22.06.23.
//

import SwiftUI

class FieldModel2: ObservableObject {
    internal init(text: String = "", error: String? = "Does not contain 'abc'.") {
        self.text = text
        self.error = error
    }
    
    var label: String = "Field Label"
    @Published var text: String = ""
    @Published var attributedText: AttributedString = "Attributed"
    @Published var error: String? = "Does not contain 'abc'."
}

struct FormField<Content>: View where Content: View {
    var label: String
    var error: String?
    @ViewBuilder var content: ()->Content

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .padding(.horizontal, 8)
                .font(.caption)
                .foregroundColor(.gray)
            content()
                .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke()
                        .foregroundColor(error == nil ? Color(white: 0.9) : .red))
            if let error {
                Text(error)
                    .padding(.horizontal, 8)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct FormEditField: View {
    @ObservedObject var fieldModel: FieldModel2
    
    init(fieldModel: FieldModel2) {
        self.fieldModel = fieldModel
    }
    
    var body: some View {
        FormField(label: fieldModel.label, error: fieldModel.error) {
            TextField("Test", text: $fieldModel.text)
        }
    }
}

// https://danielsaidi.com/blog/2022/06/13/building-a-rich-text-editor-for-uikit-appkit-and-swiftui
struct FormEditorField: View {
    @ObservedObject var fieldModel: FieldModel2
    
    init(fieldModel: FieldModel2) {
        self.fieldModel = fieldModel
    }
    
    var body: some View {
        FormField(label: fieldModel.label, error: fieldModel.error) {
            TextEditor(text: $fieldModel.text)
        }
    }
}

#Preview {
    List {
        FormEditField(fieldModel: FieldModel2(text: "Hi", error: nil))
        FormEditField(fieldModel: FieldModel2(text: "Hi", error: "Does not contain 'abc'"))
    }
    .listStyle(.plain)
}
