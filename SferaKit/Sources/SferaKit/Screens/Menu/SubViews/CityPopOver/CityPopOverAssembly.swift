//
//  CityPopOverAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CityPopOverAssemblyInputProtocol {
    func configure() -> CityPopOverViewController
}

final class CityPopOverAssembly: CityPopOverAssemblyInputProtocol {
    
    func configure() -> CityPopOverViewController {
        let tableAdapter = CityPopOverTableAdapter()
        
        let view = CityPopOverViewController.init(tableAdapter: tableAdapter)
        
        let presenter = CityPopOverPresenter.init(view: view)
        
        let interactor = CityPopOverInteractor.init(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
