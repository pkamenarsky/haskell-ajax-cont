Asynchronous http requests using the continuation monad
=======================================================

An asynchronous ajax request function would look like this:

    ajax :: String -> (String -> IO ()) -> IO ()

This looks exactly like the type of the continuation monad: `a -> (a -> r) -> r`. Rewriting `ajax` for `ContT` yields:

    ajax :: String -> ContT () IO String

Now, we can use `ajax` in a monadic computation:

    f = do
        a <- ajax "http://bla.com"
        b <- ajax "http://example.com"
        return $ a ++ b

*Note that we write code sequentially although `ajax` is asynchronous!*
