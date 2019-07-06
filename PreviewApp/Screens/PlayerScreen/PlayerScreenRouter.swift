//
//  PlayerScreenRouter.swift
//  PreviewApp
//
//  Template created by Alberto Garcia-Muñoz.
//  Linkedin: https://www.linkedin.com/in/alberto-garcia-munoz/
//  GitHub: https://github.com/AlbGarciam
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class PlayerScreenRouter {
    
    weak var viewController: PlayerScreenViewController?
    
    static func getViewController() -> PlayerScreenViewController {
        
        let configuration = configureModule()
        
        return configuration.vc
        
    }
    
    //MARK: - Navigations
    
}

//MARK: - MVVM
extension PlayerScreenRouter {
    
    private static func configureModule() -> (vc: PlayerScreenViewController, vm: PlayerScreenViewModel, rt: PlayerScreenRouter) {
        
        let viewController = PlayerScreenViewController()
        let router = PlayerScreenRouter()
        let viewModel = PlayerScreenViewModel(repository: LocalAssetRepository.standard)
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        router.viewController = viewController
        
        return (viewController, viewModel, router)
        
    }
    
}
