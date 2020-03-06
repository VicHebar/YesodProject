{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Models.PopulateDB where

import Import
import Application (db)
import Models.ModelElement
import qualified Data.Map.Lazy as Map

script :: IO ()
script = db $ do
  time <- liftIO getCurrentTime
--Here populate Customer
  victor <- insert $ Customer {
    customerPassword = Just "facilderecordarvictor",
    customerIdent = "Victor"}
  daniel <- insert $ Customer {
    customerPassword = Just "facilderecordardaniel",
    customerIdent = "Daniel"}
  alberto <- insert $ Customer {
    customerPassword = Just "facilderecordaralberto",
    customerIdent = "Alberto"}
--Here populate Parameter
  parameterVic <- insert $ Parameter {
    parameterPar = Map.fromList [("thing 1", 1.1), ("thing 2", 1.2), ("thing 3", 1.3)],
    parameterAuthor = victor,
    parameterAlias = "Victor",
    parameterElements = [H S1, He S2, Br P2]}
  parameterDaniel <- insert $ Parameter {
    parameterPar = Map.fromList [("thing 4", 1.4), ("thing 5", 1.5), ("thing 6", 1.6)],
    parameterAuthor = daniel,
    parameterAlias = "Daniel",
    parameterElements = [Kr S1, Cu S2, Cf P2]}
  parameterAlberto <- insert $ Parameter {
    parameterPar = Map.fromList [("thing 7", 1.7), ("thing 8", 1.8), ("thing 9", 1.9)],
    parameterAuthor = alberto,
    parameterAlias = "Alberto",
    parameterElements = [Bk S1, He S2, Br P2]}
--Here Populate Comment
  let
    comVic = Comment {
      commentA = victor,
      commentD = time,
      commentT = "This is a comment from Vic"}
    comDani = Comment {
      commentA = daniel,
      commentD = time,
      commentT = "Thid is a comment from Daniel"}
    comAlbert = Comment {
      commentA = alberto,
      commentD = time,
      commentT = "This is a comment from Alberto"}
  _ <- insert $ comVic
  _ <- insert $ comDani
  _ <- insert $ comAlbert
--Here populate Post
  _ <- insert $ Post {
    postP = parameterVic,
    postA = victor,
    postD = time,
    postC = [comVic, comDani]}
  _ <- insert $ Post {
    postP = parameterDaniel,
    postA = daniel,
    postD = time,
    postC = [comDani, comAlbert]}
  _ <- insert $ Post {
    postP = parameterAlberto,
    postA = alberto,
    postD = time,
    postC = [comAlbert, comVic]}
  return ()
