module Main where

import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Data.String (fromString)
import Control.Exception (bracket)
import Data.Maybe (listToMaybe)

data User = User {
    userId   :: Int,
    userName :: String,
    userAge  :: Int
} deriving (Show)

instance FromRow User where
    fromRow = User <$> field <*> field <*> field

connectToDB :: FilePath -> IO Connection
connectToDB dbFile = open dbFile

getUsers :: Connection -> IO [User]
getUsers conn = query_ conn (fromString "SELECT id, name, age FROM users WHERE id=1")

getUser :: Connection -> Int -> IO (Maybe User)
getUser conn userId = do
    result <- query conn (fromString "SELECT id, name, age FROM users WHERE id = ?") (Only userId)
    return $ listToMaybe result

-- Function to add 5 years to age
addFiveYears :: Int -> Maybe Int
addFiveYears age = Just (age + 5)

getUpdatedAge :: Connection -> Int -> IO (Maybe Int)
getUpdatedAge conn userId = do
  maybeUser <- getUser conn userId
  return $ do
    user <- maybeUser
    addFiveYears (userAge user)

main :: IO ()
main = do
    let dbFile = "test.db"
    
    bracket (connectToDB dbFile) close $ \conn -> do
        maybeUpdatedAge <- getUpdatedAge conn 1
        case maybeUpdatedAge of
            Just age -> putStrLn $ "Updated age: " ++ show age
            Nothing -> putStrLn "User not found."
