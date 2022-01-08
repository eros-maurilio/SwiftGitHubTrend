import UIKit

class RepositoriesView: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Atributes
    
    private lazy var viewModel: RepositoriesViewModelProtocol = RepositoriesViewModel(delegate: self)
    private var rowLimit = 0
    
    // MARK: - View's Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods

private extension RepositoriesView {
    func setupView() {
        CellFactory.registerCells(for: tableView)
        CellFactory.rowSetup(for: tableView)
        setupNavBar()
        tableViewSetup()
        viewModel.loadRepositories()
        
    }
    
    func setupNavBar() {
        navigationItem.title = "Swift's Most Popular Repos"
        navigationController?.navigationBar.barTintColor = Assets.gitBar.color
        navigationController?.navigationBar.tintColor = Assets.gitLabel.color
    }
    
    func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension RepositoriesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        
        switch listSection {
        case .currentList:
            return viewModel.numberOfRows()
        case .loader:
            return viewModel.numberOfRows() >= rowLimit ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
                
        switch section {
        case .currentList:
            return CellFactory.standard(tableView,
                                           at: indexPath,
                                           forACellDTO: viewModel.dtoForRows(indexPath: indexPath),
                                           cellType: .repositories)
            
        case .loader:
            return CellFactory.loading(tableView,
                                       at: indexPath)
            
        }
    }
}

// MARK: - UITableviewDelegate

extension RepositoriesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        
        let penultRow = viewModel.numberOfRows() - 1
        
        if section == .loader && !viewModel.isLoading {
            viewModel.loadRepositories()
        }
        
        if indexPath.row == penultRow {
            rowLimit = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showRepositorie(viewModel.transporter(indexPath: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - LoadContentable

extension RepositoriesView: LoadContentable {
    func didLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func displayRepositorie(_ repoPath: String) {
        let viewController = RepoPullsView()
        viewController.setup(repoPath)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
