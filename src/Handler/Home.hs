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
--Se van a borrar
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))

import Lucid hiding (Html, toHtml)
import Text.Blaze.Html
import LucidTemplates.HomeTemplate


-- Define our data that will be used for creating the form.

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
  -- time <- liftIO getCurrentTime
  -- let ftime = take 10 $ tshow time
  -- $logWarn $ "---" ++ ftime ++ "---"
  render <- getUrlRender
  let logOutUrl = render (AuthR LogoutR)
  let logInUrl = render (AuthR LoginR)
  meval <- maybeAuth
  defaultLayout $ do
    setTitle "RDATAA"
    toWidget . preEscapedToHtml . renderText $ homePage 
