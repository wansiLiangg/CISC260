module Assignment3 where

--Question 1.1
--1.1.1
data Item = PhysicalItem Int String Float Int | DigitalDownload Int String Float String

--1.1.2
instance Show Item where
  show (PhysicalItem id name price numInStock) = "\n" ++ name ++ " (" ++ (show id) ++ ")\n" ++ "$" ++ (show price) ++ "\n" ++ (show numInStock) ++ " in stock\n"
  show (DigitalDownload id name price link) = "\n" ++ name ++ " (" ++ (show id) ++ ")\n" ++ "$" ++ (show price) ++ "\nLink: " ++ (show link) ++ "\n"
  
--1.1.3
getID :: Item -> Int
getID (PhysicalItem id _ _ _) = id
getID (DigitalDownload id _ _ _) = id

getPrice :: Item -> Float
getPrice (PhysicalItem _ _ price _) = price
getPrice (DigitalDownload _ _ price _) = price

--1.1.4
type Inventory = [Item]

--Question 1.2
--1.2.1
data Order = Order Int String [Int]

--1.2.2
instance Show Order where
  show (Order id date itemId) = "\n" ++ (show id) ++ " (" ++  date ++ ")\n" ++ "Purchased: " ++ (show itemId) ++ "\n"

--1.2.3
type Sales = [Order]

--Question 2
displayList :: Show a => [a] -> IO()
displayList aList = putStr(foldr (++) "\n" (map show aList))

--Question 3
--3.1
calculateTotal :: Order -> Inventory -> Float
calculateTotal (Order _ _ idID) inventory = (foldl (+) 0 (map getPrice (filter (\id -> elem (getID id) idID) inventory))) 
  
--3.2
payPalFees :: Sales -> Inventory -> Float 
payPalFees sales inventory = (foldr (+) 0 (map (\price -> ((calculateTotal price inventory) * 0.029 + 0.3)) sales))

--Sample values
smallTShirt = PhysicalItem 3 "Small T-shirt" 19.99 2
mediumTShirt = PhysicalItem 5 "Medium T-shirt" 19.99 10
largeTShirt = PhysicalItem 7 "Large T-shirt" 19.99 3

track1 = DigitalDownload 9 "Track 1" 0.99 "/track-1"
track2 = DigitalDownload 10 "Track 2" 0.99 "/track-2"
track3 = DigitalDownload 11 "Track 3" 0.99 "/track-3"
track4 = DigitalDownload 14 "Track 4" 0.99 "/track-4"

inventory :: Inventory
inventory = [smallTShirt, mediumTShirt, largeTShirt, track1, track2, track3, track4]

order101 = Order 101 "01/01/2019" [3,7]
order104 = Order 104 "10/01/2019" [9,10,11]
order105 = Order 105 "12/02/2019" [5]
order109 = Order 109 "25/02/2019" [9,10,11,14]

sales :: Sales
sales = [order101, order104, order105, order109]

