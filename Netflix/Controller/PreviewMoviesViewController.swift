//
//  PreviewMoviesViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/17.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import WebKit


class PreviewMoviesViewController: UIViewController {
    
    
    private let titleLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    
    private let overviewLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "This is the best movie i have ever watched "
        label.textAlignment = .center
        label.numberOfLines = 10
        return label
    }()
    
    
    private let downloadButton: UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
        
    }()
    
    
    private let WebPreview: WKWebView =
    {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Return", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        view.addSubview(WebPreview)
        navigationController?.navigationBar.barTintColor = .white
        // Do any additional setup after loading the view.
        configureUI()
        
    }
    
    
    func configureUI()
    {
        let webviewConstraints = [WebPreview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                  WebPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                  WebPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                  WebPreview.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titlelabelConstraints = [titleLabel.topAnchor.constraint(equalTo: WebPreview.bottomAnchor, constant: 20),
                                     titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let overviewcontraints = [overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                                  overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                  overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let downloadbuttonOCnstriant = [downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
                                        downloadButton.widthAnchor.constraint(equalToConstant: 160),
                                        downloadButton.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(webviewConstraints)
        NSLayoutConstraint.activate(titlelabelConstraints)
        NSLayoutConstraint.activate(overviewcontraints)
        NSLayoutConstraint.activate(downloadbuttonOCnstriant)
    }
    
    
    func configurationModel(with myModel:TitlepreviewModel)
    {
        titleLabel.text = myModel.title
        overviewLabel.text = myModel.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(myModel.CurrentMovie.id.videoId)") else {return}
    
        WebPreview.load(URLRequest(url: url))
    }
}
