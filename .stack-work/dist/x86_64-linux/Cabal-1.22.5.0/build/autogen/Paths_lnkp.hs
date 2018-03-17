module Paths_lnkp (
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

bindir     = "/home/henry/HENFILES/code/haskell/lnkp/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/bin"
libdir     = "/home/henry/HENFILES/code/haskell/lnkp/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/lib/x86_64-linux-ghc-7.10.3/lnkp-0.1.0.0-GNYryzMqP6u6gzzcCQilzg"
datadir    = "/home/henry/HENFILES/code/haskell/lnkp/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/share/x86_64-linux-ghc-7.10.3/lnkp-0.1.0.0"
libexecdir = "/home/henry/HENFILES/code/haskell/lnkp/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/libexec"
sysconfdir = "/home/henry/HENFILES/code/haskell/lnkp/.stack-work/install/x86_64-linux/lts-6.12/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "lnkp_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "lnkp_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "lnkp_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "lnkp_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "lnkp_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
