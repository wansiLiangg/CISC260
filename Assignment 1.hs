module Jan28 where

--Question 1
convertFromBinary :: Int -> Int
convertFromBinary n
  |n < 0 = error "convertFromBinary requires a positive argument"
  |n == 0 = 0
  |lastNum > 1 = error "number greater than 1"
  |otherwise = 1*lastNum + 2*convertFromBinary rest
  where 
    lastNum = mod n 10
    rest = div (n-lastNum) 10
    
--Question 2
countStepsInBinarySearchHelper :: Int -> Int -> Int -> Int
countStepsInBinarySearchHelper target upperBound lowerBound
  |target > upperBound = error "The value is not in range"
  |target <= 0 || upperBound <= 0 = error "None of the parameters can be negative"
  |target == mid = 1
  |target > mid = 1 + countStepsInBinarySearchHelper target upperBound (mid+1)
  |target < mid = 1 + countStepsInBinarySearchHelper target (mid-1) lowerBound
  where
    mid = div (upperBound + lowerBound) 2
  
countStepsInBinarySearch :: Int -> Int -> Int
countStepsInBinarySearch target upperBound 
  =countStepsInBinarySearchHelper target upperBound 1
  
--Question 3
countNestedForwardsHelperI :: Int -> Int -> Int -> Int
countNestedForwardsHelperI limit i counter
  |i < limit = countNestedForwardsHelperJ limit i i counter
  |otherwise = counter
  
countNestedForwardsHelperJ :: Int -> Int -> Int -> Int -> Int
countNestedForwardsHelperJ limit j i counter
  |j < limit = countNestedForwardsHelperJ limit (j+1) i (counter+1)
  |otherwise = countNestedForwardsHelperI limit (i+1) counter
  
countNestedForwards :: Int -> Int
countNestedForwards limit
  |limit < 0 = error "countNestedForwards requires a positive argument"
  |otherwise = countNestedForwardsHelperI limit 0 0
  
 