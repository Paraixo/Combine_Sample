//
//  ViewModelProtocol.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/17.
//

import Foundation
import Combine
import SwiftUI

protocol ViewModelObject: ObservableObject {

    associatedtype Input: InputObject
    associatedtype Binding: BindingObject
    associatedtype Output: OutputObject

    var input: Input { get }
    var binding: Binding { get }
    var output: Output { get }

}

extension ViewModelObject where Binding.ObjectWillChangePublisher == ObservableObjectPublisher, Output.ObjectWillChangePublisher == ObservableObjectPublisher {

    var objectWillChange: AnyPublisher<Void, Never> {
        return Publishers.Merge(binding.objectWillChange, output.objectWillChange).eraseToAnyPublisher()
    }

}

protocol InputObject: AnyObject {
}

protocol BindingObject: ObservableObject {
}

protocol OutputObject: ObservableObject {
}

@propertyWrapper struct BindableObject<T: BindingObject> {

    @dynamicMemberLookup struct Wrapper {
        fileprivate let binding: T
        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<T, Value>) -> Binding<Value> {
            return .init(
                get: { self.binding[keyPath: keyPath] },
                set: { self.binding[keyPath: keyPath] = $0 }
            )
        }
    }

    var wrappedValue: T

    var projectedValue: Wrapper {
        return Wrapper(binding: wrappedValue)
    }

}
