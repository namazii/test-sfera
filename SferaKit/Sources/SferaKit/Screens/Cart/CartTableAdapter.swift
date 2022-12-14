//
//  CartTableAdapter.swift
//  
//
//  Created by Назар Ткаченко on 17.12.2022.
//

import UIKit

protocol CartTableAdapterOutputProtocol: AnyObject {
    func sendProducts(_ products: [Product])
    func tableReloadData()
}

final class CartTableAdapter: NSObject {
    weak var presenter: CartTableAdapterOutputProtocol?
    weak var view: CartCellDelegate?
    var products: [Product] = []
}

//MARK: - UITableViewDelegate
extension CartTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID, for: indexPath) as? CartCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(model: products[indexPath.row])
        
        return cell
    }
}

//MARK: - CartCellDelegate
extension CartTableAdapter: CartCellDelegate {
    func cartCell(counter: Int, product: Product) {
        guard let productIndex = products.firstIndex(where: {$0.id == product.id }) else { return }
        
        products[productIndex].count = counter
        
        if counter == 0 {
            products.remove(at: productIndex)
            
            presenter?.tableReloadData()
        }
        presenter?.sendProducts(products)
    }
}
