//
//  ViewController.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/21.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit

class CAMainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Private Methods
    private func initView() {
        recordButton.layer.cornerRadius = recordButton.bounds.size.width / 2
    }
    
    
    // MARK: - Actions
    @IBAction func didTouchRecord(_ sender: Any) {
    }
    
}

extension CAMainViewController {
    
    enum SegueIdentifier: String {
        case showDetail
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let id = SegueIdentifier(rawValue: identifier) else { return }
        
        switch id {
        case .showDetail:
            guard let destination = segue.destination as? CAMainTableViewController else { return }
            
        }
    }
}

