//
//  ViewController.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 03/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Instance Properties

    var loadingVC = LoadingViewController()
    var uiController = HomeView()
    var viewModel: HomeViewModel
    private var search = UISearchController()
    
    //MARK: - Initialization

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingVC.modalPresentationStyle = .fullScreen
        loadingVC.modalTransitionStyle = .crossDissolve
        present(loadingVC, animated: true, completion: nil)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.isNavigationBarHidden = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (t) in
            self.dismiss(animated: true)
            self.setupView()
            self.setupTableView()
            self.setupSearchBar()
            self.viewModel.searchCompanyByText()
            self.viewModel.companiesFound = { [weak self] in
                self?.uiController.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Functions

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(uiController)
        uiController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            uiController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            uiController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        uiController.tableView.delegate = self
        uiController.tableView.dataSource = self
        uiController.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
    }

    private func setupSearchBar() {
        uiController.searchBar.delegate = self
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func refreshData() {
        uiController.tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }

    @objc func reload() {
        viewModel.searchCompanyByText()
    }
    
    func reloadRows(indexPath: IndexPath) {
        uiController.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}


//MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let companies = viewModel.companies[indexPath.item]
        let descriptVC = DescriptionViewController()
        descriptVC.title = companies.enterprise_name
        descriptVC.uiController.secondLabel.text = companies.description
        self.navigationController?.pushViewController(descriptVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as? HomeTableViewCell else {
            fatalError("Failed to dequeue ImageTableViewCell")
        }
        cell.setup(with: HomeTableViewCellViewModel(companie: viewModel.companies[indexPath.item])) { image in
            self.reloadRows(indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


