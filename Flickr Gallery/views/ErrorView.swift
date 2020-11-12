//
//  ErrorView.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 15/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate: class {
    func refreshSearch()
    func continueOffline()
}

class ErrorView: UIView {
    
    private var connectionIsOn: Bool!
    private var resultIsEmpty: Bool?
    weak var delegate: ErrorViewDelegate?
    
    private lazy var errorTitleLabel: Label = {
        let label = Label()
        label.type = SemiBoldLabel(title: kErrorTitle)
        return label
    }()
    
    private lazy var errorDetailLabel: Label = {
        let errorDetailLabel = Label()
        errorDetailLabel.type = MediumLabel(title: "")
        return errorDetailLabel
    }()
    
    private lazy var tryAgainButton: Button = {
        let button = Button(type: .system)
        button.type = LargeButton(title: kTryAgain)
        button.addTarget(self, action: #selector(refreshSearch), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueOfflineButton: Button = {
        let button = Button(type: .system)
        button.type = LargeButton(title: kContinueOffline)
        button.addTarget(self, action: #selector(continueOffline), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: StackView = {
        let stackView = StackView()
        stackView.type = VerticalStackView()
        return stackView
    }()
    
    init(frame: CGRect, noConnection: Bool, resultIsEmpty: Bool? = nil) {
        super.init(frame: frame)
        self.connectionIsOn = noConnection
        self.resultIsEmpty = resultIsEmpty
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup methods
    
    func setupViews() {
        self.addSubviews(stackView)
        stackView.addArrangedSubviews(errorTitleLabel,
                                      errorDetailLabel,
                                      tryAgainButton,
                                      continueOfflineButton)
    }
    
    func setupLayouts() {
        if connectionIsOn {
            if resultIsEmpty != nil, resultIsEmpty == true {
                errorDetailLabel.text = kEmptyResults
                tryAgainButton.isHidden = true
                continueOfflineButton.isHidden = true
            } else {
                errorDetailLabel.text = kErrorDescription
                tryAgainButton.isHidden = false
                continueOfflineButton.isHidden = true
            }
        } else {
            tryAgainButton.isHidden = false
            continueOfflineButton.isHidden = false
            errorDetailLabel.text = kNoConnectionDescription
        }
        tryAgainButton.addSize(height: 48)
        continueOfflineButton.addSize(height: 48)
        stackView.addSize(width: 272)
        stackView.centerView()
    }
    
    // MARK: - Action methods
    
    @objc func refreshSearch() {
        self.delegate?.refreshSearch()
    }
    
    @objc func continueOffline() {
        self.delegate?.continueOffline()
    }
}

