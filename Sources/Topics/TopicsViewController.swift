//
//  TopicsViewController.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import RxSwift
import SnapKit
import Resolver
import BackbaseDesignSystem

final class TopicsViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        self.topicsTableViewDatasource = TopicsTableViewDataSource(topicsViewModel: viewModel)
        
        let output = viewModel.bind()
        
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)

        disposeBag.insert(
            output.cancelButtonIcon.drive(cancelButton.rx.image()),
            output.title.drive(titleLabel.rx.text),
            output.continueButtonTitle.drive(continueButton.rx.title())
        )
        
    }
    
    override func loadView() {
        super.loadView()
        view.addSubviews(backgroundView, cancelButton, titleLabel, continueButton, topicsTableView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let safeArea = view.safeAreaLayoutGuide
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(DesignSystem.shared.spacer.xs)
            make.leading.equalTo(safeArea).inset(DesignSystem.shared.spacer.xs)
            make.height.equalTo(DesignSystem.shared.spacer.md * 4)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom)
            make.leading.equalTo(safeArea).inset(DesignSystem.shared.spacer.md)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeArea).inset(DesignSystem.shared.spacer.md)
            make.height.equalTo(DesignSystem.shared.sizer.sm * 6)
        }
    
        topicsTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.md)
            make.leading.trailing.equalTo(safeArea).inset(DesignSystem.shared.spacer.md)
            make.bottom.equalTo(continueButton.snp.top).offset(DesignSystem.shared.spacer.md)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration.topics.design.background(backgroundView)
        configuration.topics.design.title(titleLabel)
        configuration.topics.design.continueButton(continueButton)
        configuration.topics.design.cancelButton(cancelButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private
    
    @objc private func continueTapped() {
        dismiss(animated: true)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @LazyInjected
    private var configuration: WhatsNew.Configuration
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: TopicsViewModel?
    
    private var topicsTableViewDatasource: TopicsTableViewDataSource?
    
    private lazy var backgroundView = WhatsNew.Design.BackgroundView(frame: view.frame)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "topics.titleLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let continueButton: Button = {
       let button = Button()
        button.accessibilityIdentifier = "topics.continueButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: Button = {
        let button = Button()
        button.accessibilityIdentifier = "topics.cancelButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topicsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        tableView.dataSource = topicsTableViewDatasource
        
        tableView.registerCell(TopicCell.self)
        
        return tableView
    }()
}
