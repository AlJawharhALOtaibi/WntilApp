//
//  MainPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import Foundation
import SwiftUI
import UIKit

class ViewController: UIViewController {

    let greetingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, User!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_pic")) // Replace "profile_pic" with your actual image name
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let activityBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0.7 // Set the initial progress value
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let hiddenObject: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add subviews
        view.addSubview(greetingsLabel)
        view.addSubview(profileImageView)
        view.addSubview(activityBar)
        view.addSubview(actionButton)
        view.addSubview(hiddenObject)

        // Layout constraints
        NSLayoutConstraint.activate([
            greetingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            greetingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),

            activityBar.topAnchor.constraint(equalTo: greetingsLabel.bottomAnchor, constant: 20),
            activityBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            activityBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            actionButton.topAnchor.constraint(equalTo: activityBar.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            hiddenObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hiddenObject.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hiddenObject.widthAnchor.constraint(equalToConstant: 100),
            hiddenObject.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    @objc func buttonTapped() {
        hiddenObject.isHidden = !hiddenObject.isHidden
    }
}

