{-# LANGUAGE OverloadedStrings #-}

-- | Simple FLAC-to-OGG converter.

module Main where

import qualified Data.Text as T
import           Shelly

---

-- | Convert one FLAC file to OGG Vorbis format.
--
-- `-vn` ensures no video track is written.
convert :: T.Text -> Sh ()
convert f = when (T.isSuffixOf ".flac" f) $ do
  echo f
  let f' = T.replace ".flac" ".ogg" f
  run_ "ffmpeg" ["-i", f, "-vn", "-acodec", "libvorbis", f']

main :: IO ()
main = shelly $ pwd >>= lsT >>= mapM_ convert
