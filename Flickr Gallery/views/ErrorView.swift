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
    
    private lazy var errorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = kErrorTitle
        label.font = UIFont(name: kDefaultFont, size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var errorDetailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: kDefaultFont, size: 14)
        label.textColor = .black
        label.numberOfLines = 0 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor.init(netHex: kBlueColor)
        let buttonAttributedTitle = NSAttributedString(string: kTryAgain,
                                                       attributes: [
                                                        NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.font: UIFont(name: kDefaultFont, size: 16) as Any])
        button.setAttributedTitle(buttonAttributedTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(refreshSearch), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueOfflineButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor.init(netHex: kBlueColor)
        let buttonAttributedTitle = NSAttributedString(string: kContinueOffline,
                                                       attributes: [
                                                        NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.font: UIFont(name: kDefaultFont, size: 16) as Any])
        button.setAttributedTitle(buttonAttributedTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueOffline), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.configureStackView(spacing: 16,
                                     axis: .vertical)
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
    
    // MARK: - Setop methods
    
    func setupViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubviews(errorTitleLabel, errorDetailLabel, tryAgainButton, continueOfflineButton)
    }
    
    func setupLayouts() {
        if connectionIsOn {
            var description = ""
            if resultIsEmpty != nil, resultIsEmpty == true {
                description = kEmptyResults
                tryAgainButton.isHidden = true
                continueOfflineButton.isHidden = true
            } else {
                description = kErrorDescription
                tryAgainButton.isHidden = false
                continueOfflineButton.isHidden = true
            }
            errorDetailLabel.text = description
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

