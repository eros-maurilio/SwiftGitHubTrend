import UIKit

class RepositoriesView: UIViewController {
    
    enum TableSection: Int {
        case reposList
        case loader
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var viewModel: RepositoriesViewModelProtocol = RepositoriesViewModel(delegate: self)
    private var rowLimit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
}

private extension RepositoriesView {
    func setupView() {
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        viewModel.loadRepositories()
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCell() {
        tableView.register(RepositorieViewCell.self)
        tableView.register(LoadingCell.self)
    }
    
    func repoCell(_ tableView: UITableView, at indexPath: IndexPath, forRepositorieCellDTO repositorieCellDTO: CellDTO) -> RepositorieViewCell {
        let cell = tableView.dequeCell(RepositorieViewCell.self, indexPath)
        cell.fill(dto: repositorieCellDTO)
        return cell
    }
    
    func loadingCell(_ tableView: UITableView, at indexPath: IndexPath) -> LoadingCell {
        let cell = tableView.dequeCell(LoadingCell.self, indexPath)
        cell.startLoadingAnimation()
        return cell
    }
}

extension RepositoriesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        
        if section == .loader && !viewModel.isLoading {
            viewModel.loadRepositories()
        }
        
        if indexPath.row == viewModel.numberOfRows() - 1 {
            rowLimit = indexPath.row
        }
    }
}

extension RepositoriesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        
        switch listSection {
        case .reposList:
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
        case .reposList:
            return repoCell(tableView, at: indexPath, forRepositorieCellDTO: viewModel.dtoForRows(indexPath: indexPath))

        case .loader:
            return loadingCell(tableView, at: indexPath)

        }
    }
}

extension RepositoriesView: LoadContentable {
    func didLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func displayRepositorie(_ repo: String) {
        
    }
}
