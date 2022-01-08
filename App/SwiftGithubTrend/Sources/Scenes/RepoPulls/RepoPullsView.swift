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
        registerCell()
        tableViewSetup()
        rowSetup()
    }
    
    func registerCell() {
        tableView.register(RepositorieViewCell.self)
    }
    
    func repoCell(_ tableView: UITableView, at indexPath: IndexPath, forRepositorieCellDTO repositorieCellDTO: CellDTO) -> RepositorieViewCell {
        let cell = tableView.dequeCell(RepositorieViewCell.self, indexPath)
        cell.pullCell(dto: repositorieCellDTO)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func rowSetup() {
        tableView.estimatedRowHeight = Layout.Cell.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension RepoPullsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        repoCell(tableView, at: indexPath, forRepositorieCellDTO: viewModel.dtoForRows(indexPath: indexPath))
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
