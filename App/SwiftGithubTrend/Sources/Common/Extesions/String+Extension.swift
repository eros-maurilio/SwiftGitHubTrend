extension String {
    func insertSlash(in string: String) -> String {
        var currentString = string
        currentString.insert("/", at: currentString.endIndex)
        
       return currentString
    }
}
