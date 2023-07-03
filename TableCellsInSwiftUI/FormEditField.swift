//
//  FormEditField.swift
//  TableCellsInSwiftUI
//
//  Created by Alexander Jährling on 22.06.23.
//

import SwiftUI

class FieldModel2: ObservableObject {
    enum FieldType: Int {
        case edit
        case editor
        case multiSelect
        case singleSelect
        case date
    }
    internal init(label: String = "Field Label", text: String = "", error: String? = "Does not contain 'abc'.") {
        self.type = FieldType(rawValue: Int.random(in: FieldType.edit.rawValue...FieldType.date.rawValue)) ?? .edit
        self.label = label
        self.text = text
        self.error = error
    }
    
    var type: FieldType
    var label: String = "Field Label"
    @Published var text: String = ""
    @Published var attributedText: AttributedString = "Attributed"
    @Published var error: String? = "Does not contain 'abc'."
    @Published var selection = Set<String>(["Item 1", "Item 5"])
    @Published var singleSelection = ""
    @Published var date = Date.now
}

struct FormField<Content>: View where Content: View {
    @ObservedObject var fieldModel: FieldModel2
    @ViewBuilder var content: (ObservedObject<FieldModel2>, Binding<String>)->Content

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(fieldModel.label)
                .padding(.horizontal, 8)
                .font(.caption)
                .foregroundColor(.gray)
            content(_fieldModel, $fieldModel.text)
                .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke()
                        .foregroundColor(fieldModel.error == nil ? Color(white: 0.9) : .red))
            if let error = fieldModel.error {
                Text(error)
                    .padding(.horizontal, 8)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .listRowSeparator(.hidden)
    }
}

//struct FormEditField: View {
//    @ObservedObject var fieldModel: FieldModel2
//    
//    init(fieldModel: FieldModel2) {
//        self.fieldModel = fieldModel
//    }
//    
//    var body: some View {
//        FormField(label: fieldModel.label, error: fieldModel.error) {
//            TextField("Test", text: $fieldModel.text)
//        }
//    }
//}

// https://danielsaidi.com/blog/2022/06/13/building-a-rich-text-editor-for-uikit-appkit-and-swiftui
//struct FormEditorField: View {
//    @ObservedObject var fieldModel: FieldModel2
//    
//    init(fieldModel: FieldModel2) {
//        self.fieldModel = fieldModel
//    }
//    
//    var body: some View {
//        FormField(label: fieldModel.label, error: fieldModel.error) {
//            TextEditor(text: $fieldModel.text)
//        }
//    }
//}

#Preview {
    List {
        FormField(fieldModel: FieldModel2(text: "Hi", error: nil)) { model, value in
            TextField(model.wrappedValue.label, text: value)
        }
        FormField(fieldModel: FieldModel2(text: "Hi", error: "Does not contain 'abc'")) {
            TextEditor(text: $1)
        }
    }
    .listStyle(.plain)
}
