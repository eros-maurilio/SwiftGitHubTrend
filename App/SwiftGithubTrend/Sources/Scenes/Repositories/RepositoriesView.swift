import UIKit

class RepositoriesView: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var viewModel: RepositoriesViewModelProtocol = RepositoriesViewModel(delegate: self)
    
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
    }
    
    func registerCell() {
        tableView.register(RepositorieViewCell.self)
    }
    
    func cell(_ tableView: UITableView, at indexPath: IndexPath, forRepositorieCellDTO repositorieCellDTO: CellDTO) -> RepositorieViewCell {
        let cell = tableView.dequeCell(RepositorieViewCell.self, indexPath)
        cell.fill(dto: repositorieCellDTO)
        return cell
    }
}

extension RepositoriesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRows() - 1 { // TODO: There's probably a better way to present it here.
            viewModel.loadRepositories()
        }
    }
}

extension RepositoriesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell(tableView, at: indexPath, forRepositorieCellDTO: viewModel.dtoForRows(indexPath: indexPath))
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
