//
//  main.swift
//  LSPPrinciple
//
//  Created by Ahmad Atef on 10/12/2024.
//

import Foundation

protocol Restriction {
    func ableToPurchase(by customer: Customer) -> Bool
}

protocol Item {
    var label: String { get }
    var price: Double { get }
    var restrictions: [Restriction] { get }
}

extension Item {
    /// By default no restriction for item.
    var restrictions: [Restriction] { [] }
}

struct Food: Item {
    let label: String
    let price: Double
}

protocol Taxable {
    var taxRate: Double { get }
}



struct AgeRestriction: Restriction {
    let minimumAge: Int
    
    func ableToPurchase(by customer: Customer) -> Bool {
        customer.age >= minimumAge
    }
}

struct Customer {
    let age: Int
    let hasPrescription: Bool
}

struct Good: Item, Taxable {
    let label: String
    let price: Double
    let taxRate: Double
}

struct Beer: Item, Taxable {
    let label: String = "Beer"
    let price: Double = 5
    let taxRate: Double = 0.1
    
    var restrictions: [Restriction] { [AgeRestriction(minimumAge: 18)] }
}

struct MedicalRestriction: Restriction {
    func ableToPurchase(by customer: Customer) -> Bool {
        customer.hasPrescription
    }
}

struct Medicine: Item {
    let label: String
    let price: Double
    var restrictions: [Restriction] {
        [
            MedicalRestriction(),
            AgeRestriction(minimumAge: 15)
        ]
    }
}

func calculateTotalPrice(for items: [Item], customer: Customer){
    var totalPrice: Double = 0
    var subTotal: Double = 0
    var taxSubTotal: Double = 0
    
    for item in items {
        if let failedRestriction = item.restrictions.first(where: { !$0.ableToPurchase(by: customer)}) {
            print("Failed to checkout the item: \(item.label), failed restriction: \(failedRestriction)")
            continue
        }
        
        print("Item: \(item.label) \t \t Price: \(item.price)")
        subTotal += item.price
        
        if let taxableItem = item as? Taxable {
            taxSubTotal += item.price * taxableItem.taxRate
            print("TAX: \(taxSubTotal)")
            print("PRICE + TAX: \( item.price + taxSubTotal)")
        }
        
        print("---------------------------------------")
    }
    
    totalPrice = subTotal + taxSubTotal
    print("TOTAL: \(totalPrice)")
}

var items: [Item] = [
    Food(label: "Apple", price: 1.5),
    Food(label: "Banana", price: 2.5),
    Good(label: "Candy Bar", price: 4, taxRate: 0.1),
    Beer(),
    Medicine(label: "Panadol", price: 6.1)
]

// 1.5
// 2.5
// 4 + 0.4 = 4.4
// 5 + 0.5 = 5.5

calculateTotalPrice(for: items, customer: Customer(age: 20, hasPrescription: true))


print("------------------------")



//class Bird {
//    let id = UUID()
//    func fly() -> String {
//        "Bird is flaying"
//    }
//}

//class Eagle: Bird {
//    override func fly() -> String {
//        "Eagle is flying hight"
//    }
//}
//
//class Penguin: Bird {
//    override func fly() -> String {
//        fatalError("Penguin can't fly ")
//    }
//}
//
//func fly(_ birds: Bird...) {
//    for bird in birds {
//        print(bird.fly())
//    }
//}
//
//let p1 = Penguin()
//let e1 = Eagle()
//fly(e1, p1)


class Bird {
    let id = UUID()
}

protocol Flyable {
    func fly() -> String
}

class Eagle: Bird, Flyable {
    func fly() -> String {
        "Eagle flying high"
    }
}

class Pengioun: Bird {
    
}

let e1 = Eagle()
let p1 = Pengioun()

func makeBirdFly(_ flyable: Flyable) {
    print(flyable.fly())
}

makeBirdFly(e1)
//makeBirdFly(p1)


