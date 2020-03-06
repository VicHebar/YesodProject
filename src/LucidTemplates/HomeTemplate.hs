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
import           System.IO (stdout, hSetEncoding, utf8)
import           Data.Text.Lazy.IO as L
import qualified Data.Text as T
import           Database.Persist.Sql ( fromSqlKey )
import           Models.ModelElement

homePage :: [Entity Customer] -> [Entity Parameter] -> [Entity Post] -> Html ()
homePage customers parameters posts= do
  toHtmlRaw "<!-- Products -->"
  section_ [ class_ "about full-screen d-lg-flex justify-content-center align-items-center", id_ "products" ] $ do
    div_ [ class_ "container" ] $ do
      p_ [] "Posts"
      div_ [ class_ "panel panel-default" ] $ do
        div_ [ class_ "panel-heading" ] $ do
          h3_ [ class_ "panel-title" ] $ "Tabla de Posts"
        div_ [ class_ "panel-body" ] $ do
          table_ [ class_ "table table-responsive table-condensed table-sm" ] $ do
            thead_ $ do
              tr_ $ do
                th_ "Autor"
                th_ "Parametros"
                th_ "Comentario(s)"
                th_ "Fecha/Hora"
            tbody_ $ do
               -- forM_ customers $ \c -> do
               --   tr_ $ do
               --     td_ [ align_ "left" ] $ iddCustomer c
               --     td_ [ align_ "left" ] $ identCustomer c
               --     td_ [ align_ "left" ] $ passCustomer c
               forM_ posts $ \p -> do
                 tr_ $ do
                   td_ [ align_ "left" ] $ identCustomer (customerPost customers p)
                   td_ [ align_ "left" ] $ elementsPost parameters p --toHtml (parameterIdPostT p)
                   td_ [ align_ "left" ] $ toHtml ( T.pack (concatWords ([T.unpack s | s <- map commentT (commentsPost p)])))
                   td_ [ align_ "left" ] $ timePost p
               -- forM_ parameters $ \p -> do
               --   tr_ $ do
               --     td_ [ align_ "left" ] $ toHtml (iddParameterT p)

elementsPost :: [Entity Parameter] -> Entity Post -> Html ()
elementsPost prmtrs pst = toHtml (T.pack elmnts)
  where
    elmnts = concatWords (map show (elementsPostL prmtrs pst))

concatWords :: [String] -> String
concatWords [] = ""
concatWords (wd:wds) = wd ++ ", " ++ (concatWords wds)

elementsPostL :: [Entity Parameter] -> Entity Post -> [Models.ModelElement.Element]
elementsPostL [] _ = [Models.ModelElement.EmptyElement]
elementsPostL prmtrs pst = parameterElements (entityVal (parameterPost prmtrs pst))

commentsPost :: Entity Post -> [Comment]
commentsPost = postC . entityVal

parameterPost :: [Entity Parameter] -> Entity Post -> Entity Parameter
parameterPost prmtrs pst = x
  where
    (x:xs) = filter (\p -> iddParameterT p == parameterIdPostT pst) prmtrs

customerPost :: [Entity Customer] -> Entity Post -> Entity Customer
customerPost custmrs pst = x
  where
    (x:xs) = filter (\c -> iddCustomerT c == customerIdPostT pst) custmrs

iddParameterT :: Entity Parameter -> Text
iddParameterT = tshow . fromSqlKey . entityKey

parameterIdPostT :: Entity Post -> Text
parameterIdPostT = tshow . fromSqlKey . postP . entityVal

customerIdPostT :: Entity Post -> Text
customerIdPostT = tshow . fromSqlKey . postA . entityVal

timePost :: Entity Post -> Html ()
timePost = toHtml . take 19 . show . postD . entityVal

-- parameterIdPostT :: Entity Post -> Text
-- parameterIdPostT = tshow . fromSqlKey . entityKey

identCustomer :: Entity Customer -> Html ()
identCustomer = toHtml . customerIdent . entityVal

passCustomer :: Entity Customer -> Html ()
passCustomer = toHtml . customerPassword . entityVal

iddCustomer :: Entity Customer -> Html ()
iddCustomer c = toHtml . tshow . fromSqlKey . entityKey $ c

iddCustomerT :: Entity Customer -> Text
iddCustomerT = tshow . fromSqlKey . entityKey

build :: Monad m => Builder -> HtmlT m ()
build b = LucidBase.HtmlT (return (const b,()))
{-# INLINE build #-}

instance ToHtml (Maybe Text) where
  toHtml Nothing = build . Blaze.fromHtmlEscapedText $ ""
  toHtml (Just a) = build . Blaze.fromHtmlEscapedText $ a
  
  toHtmlRaw Nothing = build . Blaze.fromText $ ""
  toHtmlRaw (Just a) = build . Blaze.fromText $ a
