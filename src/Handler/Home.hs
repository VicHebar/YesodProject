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
import Database.Esqueleto ((^.), (==.))
import Prelude (read)
import Database.Persist.Sql (toSqlKey)

getHomeR :: Handler Html
getHomeR = do
  customers :: [Entity Customer] <- runDB $
               E.select $
               E.from $ \c -> do
               return c
  parameters :: [Entity Parameter] <- runDB $
                E.select $
                E.from $ \c -> do
                return c
  posts :: [Entity Post] <- runDB $
           E.select $
           E.from $ \c -> do
           return c
  -- render <- getUrlRender
  -- meval <- maybeAuth
  defaultLayout $ do
    setTitle "Hola Mundo"
    toWidget . preEscapedToHtml . renderText $ homePage customers parameters posts

postHomeR :: Handler ()
postHomeR = do
  time <- liftIO getCurrentTime
  paramId <- runInputPost $ ireq textField "paramIdN"
  custId <- runInputPost $ ireq textField "custIdN"
  comment <- runInputPost $ ireq textField "custIdN"
  let custormerid :: CustomerId = toSqlKey $ read $ unpack custId
      parameterid :: ParameterId = toSqlKey $ read $ unpack paramId
  -- param :: [Entity Parameter] <- runDB $
  --                                 E.select $
  --                                 E.from $ \p -> do
  --                                 E.where_ (p ^. ParameterId E.==. E.val parameterid)
  --                                 return p
  -- custom :: [Entity Customer] <- runDB $
  --                                 E.select $
  --                                 E.from $ \c -> do
  --                                 E.where_ (c ^. CustomerId E.==. E.val custormerid)
  --                                 return c
  let
    newComment = Comment {
      commentA = custormerid,
      commentD = time,
      commentT = comment }
    newRT = Randtable {
      randtableSometext = (pack "Holaa")
                      }
  runDB $ do
    _ <- insert $ newRT
    -- insert $ newComment
    -- _ <- insert $ Post {
    --   postP = parameterid,
    --   postA = custormerid,
    --   postD = time,
    --   postC = [newComment] }
    return ()

