import UIKit

class RepoPullsView: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Delegate
    
    private lazy var viewModel: RepoPullsViewModelProtocol = RepoPullsViewModel(delegate: self)
    
    // MARK: - View's Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setup(_ repoInfos: [String]) {
        
        if let repoPath = repoInfos.safeObject(index: 0) {
            viewModel.setup(repoPath)
        }
        
        if let repoTitle = repoInfos.safeObject(index: 1) {
            navigationItem.title = repoTitle
        }
    }
}

// MARK: - Private Methods

private extension RepoPullsView {
    
    func setupView() {
        CellFactory.registerCells(for: tableView)
        CellFactory.rowSetup(for: tableView)
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func alertSetup(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: dismissView))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissView(action: UIAlertAction? = nil) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - TableView DataSource

extension RepoPullsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        
        switch listSection {
        case .currentList:
            return viewModel.numberOfRows()
        case .loader:
            return viewModel.isLoading ? 1 : 0
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
                                        cellType: .pulls,
                                        isSelectionEnabled: false)
            
        case .loader:
            return CellFactory.loading(tableView,
                                       at: indexPath)
            
        }
    }
}

// MARK: - Load Content

extension RepoPullsView: LoadViewDelegate {
    
    func didLoadContent(success: Bool, error: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if success {
                self.tableView.reloadData()
            } else {
                self.alertSetup(message: error ?? "")
            }
        }
    }
}
