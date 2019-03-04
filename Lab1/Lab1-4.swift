class Solution {
    func fib(_ N: Int) -> Int {
    guard N > 1 else { return N }
    return fib(N-1) + fib(N-2)
    }      
}