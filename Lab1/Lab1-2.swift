class Solution {
    func sortArrayByParity(_ A: [Int]) -> [Int] {
        let evenElements = A.filter { $0 % 2 == 0 }
        let oddElements = A.filter { $0 % 2 == 1 }
        return evenElements + oddElements
    }
}