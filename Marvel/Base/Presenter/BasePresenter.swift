//
//  BasePresenter.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

class BasePresenter<T: BaseView> {
    weak var view: T?
}
