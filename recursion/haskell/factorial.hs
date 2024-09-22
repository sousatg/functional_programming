-- Factorial of a number n
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial(n-1)

-- Factorial of a nnumber n using if then else
factorial1 :: Int -> Int
factorial1 n = if n <= 1 then 1 else n * factorial1(n-1)


main :: IO ()
main = do
    putStrLn $ "Factorial function of 3: " ++ show (factorial 3)
    putStrLn $ "If Then Else Factorial function of 3: " ++ show (factorial 3)