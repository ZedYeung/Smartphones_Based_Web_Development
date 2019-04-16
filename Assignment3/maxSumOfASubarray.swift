func maxSumOfASubarray(arr: [Int]) -> Int {
    if (arr.count == 0) {
      return 0
    }

    var res: Int = arr[0]
    var cur: Int = arr[0]

    for index in 1...(arr.count - 1) {
        cur = max(cur + arr[index], arr[index])
        res = max(cur, res)
    }
    return res
}

print(maxSumOfASubarray(arr: [-2, -3, 4, -1, -2, 1, 5, 3]))