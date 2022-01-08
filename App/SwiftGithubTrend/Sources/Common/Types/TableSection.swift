enum TableSection: Int {
    
    case currentList
    case loader
    
    static func sectionsCount() -> Int {
        [TableSection.currentList, TableSection.loader].count
    }
}
