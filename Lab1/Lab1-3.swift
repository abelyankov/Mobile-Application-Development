class Solution {
    func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
        return A.map({$0.reversed()}).map({$0.map({$0 == 0 ? 1 : 0 })})
    }
}