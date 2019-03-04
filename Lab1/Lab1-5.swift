class Solution {
    func arrayPairSum(_ nums: [Int]) -> Int {
    var sum = 0
    
    let sortNums = nums.sorted(by: <)
    
    for i in 0..<sortNums.count where i % 2 == 0 {
        sum += sortNums[i]
    }
    
    return sum
    }
}