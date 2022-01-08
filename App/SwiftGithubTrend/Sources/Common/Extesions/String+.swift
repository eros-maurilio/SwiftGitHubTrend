extension String {
    
    func insertSlash(in string: String) -> String {
        var currentString = string
    
        currentString.insert("/", at: currentString.startIndex)
        
       return currentString
    }
}
