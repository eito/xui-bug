//
//  ContentView.swift
//  xui-bug
//
//  Created by Eric Ito on 1/9/23.
//

import SwiftUI
import XUI

protocol OtherViewModelItemProtocol {
    var name: String { get }
}

protocol OtherViewModelProtocol: ViewModel, ObservableObject, Identifiable {

    var otherText: String { get }

    var items: [ItemType] { get }

    associatedtype ItemType: OtherViewModelItemProtocol
}

protocol MainViewModelProtocol: ViewModel {

    var text: String { get }

    var otherViewModel: OtherViewModelType? { get set }

    associatedtype OtherViewModelType: OtherViewModelProtocol
}

class OtherViewModelItem: OtherViewModelItemProtocol {
    let name = "Other View Model Item"
}

class OtherViewModel: OtherViewModelProtocol {

    let id = UUID()
    let otherText = "Other View model"

    let items = [OtherViewModelItem()]

    init() {}
}

class MainViewModel: MainViewModelProtocol, ObservableObject {

    let text = "Hello from MainViewModel"

    @Published var otherViewModel: OtherViewModel?

    init() {

    }
}

// Fails to compile
//
struct ContentView: View {

    @Store
    var viewModel: any MainViewModelProtocol

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .sheet(item: $viewModel.otherViewModel) { viewModel in
            Text(viewModel.otherText)
        }
    }
}

// Compiles
//
//struct ContentView: View {
//
//    @Store
//    var viewModel: any MainViewModelProtocol
//
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

// Compiles -- remove ContentView(viewModel: MainViewModel()) and replace with ContentView()
//
//struct ContentView: View {
//
//    @Store
//    var viewModel = MainViewModel()
//
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//        .sheet(item: $viewModel.otherViewModel) { viewModel in
//            Text(viewModel.otherText)
//        }
//    }
//}
