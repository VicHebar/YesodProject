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

getHomeR :: Handler Html
getHomeR = do
  render <- getUrlRender
  meval <- maybeAuth
  defaultLayout $ do
    setTitle "Hola Mundo"
    toWidget . preEscapedToHtml . renderText $ homePage 
