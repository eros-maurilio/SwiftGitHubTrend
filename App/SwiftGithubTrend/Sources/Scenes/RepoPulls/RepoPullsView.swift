import UIKit

class RepoPullsView: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel: RepoPullsViewModelProtocol = RepoPullsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setup(_ repoPath: String) {
        viewModel.setup(repoPath)
    }
}

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
}

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
                                           cellType: .pulls)
        case .loader:
            return CellFactory.loading(tableView,
                                       at: indexPath)
            
        }
    }
    
}

extension RepoPullsView: LoadViewDelegate {
    func didLoadContent() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
