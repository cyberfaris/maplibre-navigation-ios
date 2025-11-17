#if canImport(CarPlay)
import CarPlay
import Foundation

@available(iOS 12.0, *)
extension CarPlayManager: CPSearchTemplateDelegate {

    public static let CarPlayGeocodedPlacemarkKey: String = "MBGecodedPlacemark"

    static var MaximumInitialSearchResults: UInt = 5
    static var MaximumExtendedSearchResults: UInt = 10

    // MARK: - CPSearchTemplateDelegate

    public func searchTemplate(_ searchTemplate: CPSearchTemplate,
                               updatedSearchText searchText: String,
                               completionHandler: @escaping ([CPListItem]) -> Void) {

        let title = "Search not implemented"
        let item = CPListItem(text: title, detailText: nil)
        completionHandler([item])
    }

    public func searchTemplateSearchButtonPressed(_ searchTemplate: CPSearchTemplate) {
        // nothing to show, no recent searches
    }

    public func searchTemplate(_ searchTemplate: CPSearchTemplate,
                               selectedResult item: CPListItem,
                               completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func searchTemplateButton(searchTemplate: CPSearchTemplate,
                              interfaceController: CPInterfaceController,
                              traitCollection: UITraitCollection) -> CPBarButton {

        let button = CPBarButton(type: .image) { [weak self] _ in
            guard let self else { return }

            if let mapTemplate = interfaceController.topTemplate as? CPMapTemplate {
                self.resetPanButtons(mapTemplate)
            }

            interfaceController.pushTemplate(searchTemplate, animated: true)
        }

        button.image = UIImage(systemName: "magnifyingglass")
        return button
    }

    // Static method required by SDK, but MapLibre has no geocoder.
    @available(iOS 12.0, *)
    public static func searchTemplate(_ searchTemplate: CPSearchTemplate,
                                      updatedSearchText searchText: String,
                                      completionHandler: @escaping ([CPListItem]) -> Void) {

        let title = "Search not implemented"
        let item = CPListItem(text: title, detailText: nil)
        completionHandler([item])
    }

    @available(iOS 12.0, *)
    public static func carPlayManager(_ searchTemplate: CPSearchTemplate,
                                      selectedResult item: CPListItem,
                                      completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    @available(iOS 12.0, *)
    static func resultsOrNoResults(_ items: [CPListItem], limit: UInt? = nil) -> [CPListItem] {
        if items.isEmpty {
            return [CPListItem(text: "No results", detailText: nil)]
        }
        if let limit {
            return Array(items.prefix(Int(limit)))
        }
        return items
    }
}

#endif
