enum TableSection: Int {
    case currentList
    case loader
    
    static func sectionCount() -> Int {
        [TableSection.currentList, TableSection.loader].count
    }
}
