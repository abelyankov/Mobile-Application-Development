class Solution {
    func sortedSquares(_ A: [Int]) -> [Int] {	
        let sqrA = A.map({ Int(pow(Double($0), 2.0))})
        let sortedA = sqrA.sorted()
        return sortedA
    }
}