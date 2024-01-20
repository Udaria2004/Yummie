//
//  CartManager.swift
//  YummieUI
//
//    Ishanvi Mohan
//    3035756311


import Foundation

class CartManager {
    static let shared = CartManager()
    
    private var dishes:[Dish] = []
    private init() {
    }
    
    var cartItems:[Dish] {
        return dishes
    }
}

extension CartManager {
    
    func addItem(item:Dish) {
        dishes.append(item)
    }
    
    func remove(item:Dish) {
        if let index = dishes.firstIndex(where: {$0.id == item.id}) {
            dishes.remove(at: index)
        }
    }
}
