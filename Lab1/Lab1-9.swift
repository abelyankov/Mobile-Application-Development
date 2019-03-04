class Solution {
        func isPalindrome(_ s: String) -> Bool {
        if s.characters.count == 0 { return true }

        let c = s.components(separatedBy: CharacterSet.alphanumerics.inverted).joined(separator: "")

        return Bool(String(c.characters).lowercased()==String(c.characters.reversed()).lowercased())
    }
}