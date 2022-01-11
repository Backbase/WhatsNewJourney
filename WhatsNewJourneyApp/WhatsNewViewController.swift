//
//  WhatsNewViewController.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import WhatsNewJourney
import Resolver
import SnapKit
import BackbaseDesignSystem

class WhatsNewViewController: UIViewController {
    
    let decoder = JSONDecoder()
    
    var dataProvider: TopicsUseCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appConfig = WhatsNew.Configuration()
        
        self.dataProvider = ContentServicesDataProvider(fileName: "testTopics.json")
        
        Resolver.register { appConfig as WhatsNew.Configuration }
        
        view.addSubview(startJourneyButton)
        view.backgroundColor = .white
        startJourneyButton.addTarget(self, action: #selector(startJourney), for: .touchUpInside)
        
        let safeArea = view.safeAreaLayoutGuide
        
        startJourneyButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).inset(DesignSystem.shared.spacer.lg)
            make.trailing.equalTo(safeArea.snp.trailing).inset(DesignSystem.shared.spacer.lg)
            make.bottom.equalTo(safeArea.snp.bottom).inset(DesignSystem.shared.spacer.lg)
        }
    }
    
    
    @IBAction func startJourney(_ sender: Any) {
        
        dataProvider?.retrieveTopics {[weak self] result in
            switch result {
            case .success(let topics):
                if let viewController = Topics.build(with: topics) {
                    DispatchQueue.main.async {
                        self?.present(viewController, animated: true)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private let startJourneyButton: Button = {
        let button = Button()
        button.setTitle("What's New", for: .normal)
        DesignSystem.shared.styles.primaryButton(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

