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
import RemoteConfig

class WhatsNewViewController: UIViewController {
    
    var dataProvider: TopicsUseCase?
    var r: RemoteConfig
    
    init(remoteConfigClient: RemoteConfig) {
        self.r = remoteConfigClient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appConfig = WhatsNew.Configuration()
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(startJourneyButton)
        view.backgroundColor = .white
        startJourneyButton.addTarget(self, action: #selector(startJourney), for: .touchUpInside)
        
        startJourneyButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).inset(DesignSystem.shared.spacer.lg)
            make.trailing.equalTo(safeArea.snp.trailing).inset(DesignSystem.shared.spacer.lg)
            make.bottom.equalTo(safeArea.snp.bottom).inset(DesignSystem.shared.spacer.lg)
        }
        
        Resolver.register { appConfig as WhatsNew.Configuration }
    }
    
    
    @IBAction func startJourney(_ sender: Any) {
        
        // Use the RemoteConfigClient to fetch the name of the datasource
        if let contentSource = DataProvider(rawValue: r.getString(name: "contentSource") ?? "") {
            switch contentSource {
            case .contentServicesDataProvider:
                self.dataProvider = ContentServicesDataProvider(fileName: "testTopics.json")
            case .remoteConfigDataProvider:
                self.dataProvider = RemoteConfigDataProvider(client: r)
            default:
                self.dataProvider = LocalDataProvider(fileName: "topics")
            }
        }
        
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

