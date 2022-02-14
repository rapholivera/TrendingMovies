//
//  ActionSheetViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol ActionSheetRouterProtocol: AnyObject {
   func dismissActionSheet()
   func dismissActionSheetWith(message: String)
}

protocol ActionSheetViewModelProtocol: BaseViewModelProtocol {
    var footerViewController: UIViewController { get }

    func didTapOutsideBottomView()
}

class ActionSheetViewModel: BaseViewModel {

    weak var router: ActionSheetRouterProtocol?

    let footerViewController: UIViewController

    init(footerViewController: UIViewController, router: ActionSheetRouterProtocol) {
        self.footerViewController = footerViewController
        self.router = router
        super.init()
    }
}

extension ActionSheetViewModel: ActionSheetViewModelProtocol {

   func didTapOutsideBottomView() {
      router?.dismissActionSheet()
   }
}
