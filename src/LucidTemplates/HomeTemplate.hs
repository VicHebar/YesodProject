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

homePage :: [Entity Customer] -> Html ()
homePage customers = do
  toHtmlRaw "<!-- Products -->"
  section_ [ class_ "about full-screen d-lg-flex justify-content-center align-items-center", id_ "products" ] $ do
    div_ [ class_ "container" ] $ do
      p_ [] "Titulos"
      div_ [ class_ "panel panel-default" ] $ do
        div_ [ class_ "panel-heading" ] $ do
          h3_ [ class_ "panel-title" ] $ "Titulos de tablas"
        div_ [ class_ "panel-body" ] $ do
          table_ [ class_ "table table-responsive table-condensed table-sm" ] $ do
            thead_ $ do
              tr_ $ do
                th_ "ID"
                th_ "Alias"
                th_ "Password"
            tbody_ $ do
               forM_ customers $ \c -> do
                 tr_ $ do
                   td_ [ align_ "left" ] $ idd c
                   td_ [ align_ "left" ] $ ident c
                   td_ [ align_ "left" ] $ pass c

ident :: Entity Customer -> Html ()
ident = toHtml . customerIdent . entityVal

pass :: Entity Customer -> Html ()
pass = toHtml . customerPassword . entityVal

idd :: Entity Customer -> Html ()
idd c = toHtml . tshow . fromSqlKey . entityKey $ c

build :: Monad m => Builder -> HtmlT m ()
build b = LucidBase.HtmlT (return (const b,()))
{-# INLINE build #-}

instance ToHtml (Maybe Text) where
  toHtml Nothing = build . Blaze.fromHtmlEscapedText $ ""
  toHtml (Just a) = build . Blaze.fromHtmlEscapedText $ a
  
  toHtmlRaw Nothing = build . Blaze.fromText $ ""
  toHtmlRaw (Just a) = build . Blaze.fromText $ a
