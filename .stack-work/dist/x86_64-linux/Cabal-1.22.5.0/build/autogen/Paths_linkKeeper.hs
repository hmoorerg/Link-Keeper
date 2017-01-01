module Paths_linkKeeper (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/henry/HENFILES/code/haskell/linkKeeper/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/bin"
libdir     = "/home/henry/HENFILES/code/haskell/linkKeeper/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/lib/x86_64-linux-ghc-7.10.3/linkKeeper-0.1.0.0-8PufJLPXghU6JuT0Be5OtU"
datadir    = "/home/henry/HENFILES/code/haskell/linkKeeper/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/share/x86_64-linux-ghc-7.10.3/linkKeeper-0.1.0.0"
libexecdir = "/home/henry/HENFILES/code/haskell/linkKeeper/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/libexec"
sysconfdir = "/home/henry/HENFILES/code/haskell/linkKeeper/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "linkKeeper_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "linkKeeper_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "linkKeeper_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "linkKeeper_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "linkKeeper_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
