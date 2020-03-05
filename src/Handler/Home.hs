{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE DeriveDataTypeable         #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE ScopedTypeVariables        #-}
module Handler.Home where

import Import
import Lucid hiding (Html, toHtml)
import Text.Blaze.Html
import LucidTemplates.HomeTemplate
import qualified Database.Esqueleto as E
import           Database.Esqueleto      ((^.), (==.))

getHomeR :: Handler Html
getHomeR = do
  customers :: [Entity Customer] <- runDB $
               E.select $
               E.from $ \c -> do
               return c
  render <- getUrlRender
  meval <- maybeAuth
  defaultLayout $ do
    setTitle "Hola Mundo"
    toWidget . preEscapedToHtml . renderText $ homePage customers
