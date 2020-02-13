{-# LANGUAGE ExtendedDefaultRules   #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE ScopedTypeVariables    #-}

module LucidTemplates.HomeTemplate where

import           Import hiding ((==.), for_, Html, toHtml, Builder)
import qualified Lucid.Base as LucidBase
import           Lucid
import           Lucid.Supplemental
import qualified Blaze.ByteString.Builder as Blaze
import qualified Blaze.ByteString.Builder.Html.Utf8 as Blaze
import           Blaze.ByteString.Builder (Builder)
import System.IO (stdout, hSetEncoding, utf8)
import Data.Text.Lazy.IO as L
import           Database.Persist.Sql ( fromSqlKey )

homePage :: Html ()
homePage =  do
  toHtmlRaw "<!-- Products -->"
  section_ [ class_ "about full-screen d-lg-flex justify-content-center align-items-center", id_ "products" ] $ do
    div_ [ class_ "container" ] $ do
      p_ [] "Hola Mundo"
