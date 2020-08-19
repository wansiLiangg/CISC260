module Assignment2 where

--Question 1
showFormattedString :: [[Int]] -> IO()
showFormattedString listOfLists 
  = putStrLn (getFormattedString listOfLists) 

getFormattedString :: [[Int]] -> String
getFormattedString nestedLists
  |nestedLists == [] = ""
  |length nestedLists == 1 = show (head nestedLists)
  |otherwise = show (head nestedLists) ++ "\n" ++ getFormattedString (tail nestedLists)
 
--Question 2
parenthesesAreBalanced :: String -> Bool
parenthesesAreBalanced str
  |result == 0 = True
  |otherwise = False
  where
    result = parenthesesAreBalancedHelper str 
  
parenthesesAreBalancedHelper :: String -> Int
parenthesesAreBalancedHelper str 
  |str == "" = 0
  |head str == '(' = 1 + parenthesesAreBalancedHelper (tail str)
  |head str == ')' = -1 + parenthesesAreBalancedHelper (tail str)
  |otherwise = parenthesesAreBalancedHelper (tail str)
  
--Question 3
-- The User tuple is of the form (ID, Name)
type User = (Int, String)

-- The Content tuple is of the form (ID, Title)
type Content = (Int, String)

-- The Viewing tuple is of the form (User ID, Movie ID, Timestamp)
type Viewing = (Int, Int, Int)

-- The Rating tuple is of the form (User ID, Movie ID, Rating)
type Rating = (Int, Int, Int)

-- This is sample content for the sample output and for you to test with.
-- You should absolutely add your own values to these lists to test beyond the
-- data here.
userList = [(4, "SJW"), (73, "AA"), (34, "TB")]
contentList = [(12, "Dirk Gently's Holistic Detective Agency"), (15, "Black Panther"), (81, "Brooklyn 99"), (37, "The Good Place"), (51, "Iron Fist"), (43, "Solo"), (76, "The Vietnam War"), (29, "Secret City"), (60, "Ugly Delicious")]
viewingList = [(4, 12, 1516456852), (4, 15, 1537542147), (4, 81, 1504116489), (4, 37, 1541498412), (4, 51, 1508360754), (4, 76, 1516356148), (4, 29, 1536539720), (4, 60, 1508965289), (73, 51, 1517365941), (73, 60, 1516365257), (73, 43, 1536420631), (34, 60, 1507471645), (34, 15, 1509459643) ]
ratingList = [(4, 12, 5), (4, 15, 5), (4, 81, 5), (4, 37, 5), (4, 51, 2), (4, 43, 3), (4, 76, 5), (4, 29, 5), (4, 60, 3), (73, 51, 5), (73, 60, 4), (73, 43, 5), (34, 60, 1), (34, 15, 5)]

--3.1
averageRating :: Int -> Int
averageRating id
  |id < 0 = error "The content's ID number is negative"
  |rList == [] = error "That content is not yet rated"
  |otherwise = floor (fromIntegral avg)
  where
    rList = [rating | (userId, movieId, rating) <- ratingList, movieId == id]
    total = sum rList
    avg = div total (length rList)

--3.2
watchItAgain :: Int -> [(Int, String)]
watchItAgain id
  |id < 0 = error "The user's ID number is negative"
  |exist == [] = []
  |otherwise = watchItAgainHelper movieIdList 
  where
    exist = [userId | (userId, userName) <- userList, userId == id]
    movieIdList = [movieId | (userId, movieId, rating) <- viewingList, userId == id]
    
watchItAgainHelper :: [Int] -> [(Int, String)]
watchItAgainHelper movieIdList 
  |length movieIdList == 0 = []
  |otherwise = output ++ watchItAgainHelper (tail movieIdList) 
  where
    output = [(movieId, movieTitle) | (movieId, movieTitle) <- contentList, movieId == (head movieIdList)]
    
--3.3
suggestionsForYou :: Int -> [(Int, String)]
suggestionsForYou id
  |id < 0 = error "The user's ID number is negative"
  |exist == [] = suggestionsForYouHelper3 (suggestionsForYouHelper2 allMovieIdList)
  |otherwise = suggestionsForYouHelper3 newUnviewedList 
  where
    exist = [userId | (userId, userName) <- userList, userId == id]
    viewedList = [movieId | (userId, movieId, timeStamp) <- viewingList, userId == id]
    unviewedList = suggestionsForYouHelper1 viewedList allMovieIdList
    newUnviewedList = suggestionsForYouHelper2 unviewedList
    allMovieIdList = [movieId | (movieId, title) <- contentList]
    
suggestionsForYouHelper1 :: [Int] -> [Int] -> [Int]
suggestionsForYouHelper1 viewedList allMovieIdList
  |length viewedList == 0 = allMovieIdList
  |otherwise = suggestionsForYouHelper1 (tail viewedList) newAllMovieIdList 
  where
    remove element list = filter (\e -> e /= element) allMovieIdList
    newAllMovieIdList = remove (head viewedList) allMovieIdList
    
suggestionsForYouHelper2 :: [Int] -> [Int]
suggestionsForYouHelper2 unviewedList
  |unviewedList == [] = []
  |roundedAvg < 2 = suggestionsForYouHelper2 (tail unviewedList)
  |otherwise = [(head unviewedList)] ++ suggestionsForYouHelper2 (tail unviewedList)
  where
    rList = [rating | (userId, movieId, rating) <- ratingList, movieId == (head unviewedList)]
    total = sum rList
    avg = div total (length rList)
    roundedAvg = floor (fromIntegral avg)

suggestionsForYouHelper3 :: [Int] -> [(Int, String)]
suggestionsForYouHelper3 movieIdList
  |length movieIdList == 0 = []
  |otherwise = output ++ suggestionsForYouHelper3 (tail movieIdList) 
  where
    output = [(movieId, movieTitle) | (movieId, movieTitle) <- contentList, movieId == (head movieIdList)]
      
    