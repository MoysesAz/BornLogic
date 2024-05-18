import Combine
import Foundation

extension HomeController {
    private func bindPublisher(_ publisher: AnyPublisher<[Article], Never>, to indexPath: IndexPath) {
        publisher
            .map { _ in () } // Mapeia a saída de [Article] para Void
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let cell = self.contentView.tableView.cellForRow(at: indexPath) as? CatalogCell {
                    cell.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    internal func bindAll() {
        bindHeadLines()

        bindPublisher(viewModel.generalPublisher, to: IndexPath(row: 2, section: 0))
        bindPublisher(viewModel.businessPublisher, to: IndexPath(row: 3, section: 0))
        bindPublisher(viewModel.entertainmentPublisher, to: IndexPath(row: 4, section: 0))
        bindPublisher(viewModel.healthPublisher, to: IndexPath(row: 5, section: 0))
        bindPublisher(viewModel.sciencePublisher, to: IndexPath(row: 6, section: 0))
        bindPublisher(viewModel.sportPublisher, to: IndexPath(row: 7, section: 0))
        bindPublisher(viewModel.technologyPublisher, to: IndexPath(row: 8, section: 0))

        viewModel.fetchHeadlines()
        viewModel.fetchGeneral()
        viewModel.fetchBusiness()
        viewModel.fetchEntertainment()
        viewModel.fetchHealth()
        viewModel.fetchScience()
        viewModel.fetchSport()
        viewModel.fetchTechnology()
        viewModel.fetchScience()
    }

    private func bindHeadLines() {
        viewModel.headlinesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}
