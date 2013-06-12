-- Asynchronous http requests using the continuation monad

import Control.Monad.Cont
import Control.Concurrent

import Network.HTTP

-- ajax :: String -> (String -> IO ()) -> IO ()
ajax :: String -> ContT () IO String
ajax url = ContT $ \f ->
    forkIO (simpleHTTP (getRequest url) >>= getResponseBody >>= f) >> return ()

f = do
    a <- ajax "http://bla.com"
    b <- ajax "http://example.com"
    return $ a ++ b

main = do
    runContT f putStrLn
    putStrLn "asd"
    threadDelay 5000000
