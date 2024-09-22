

fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci(x-1) + fibonacci(x-2)

main :: IO ()
main = do
    putStrLn $ "Recursive Fibonacci of 10: " ++ show (fibonacci 10)