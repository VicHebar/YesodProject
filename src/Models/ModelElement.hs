{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}

module Models.ModelElement where

import Database.Persist.TH

data Lvl = S1
         | S2
         | P2
         | S3
         | P3
         | D3
         | S4
         | P4
         | D4
         | F4
         | S5
         | P5
         | D5
         | F5
         | S6
         | P6
         | D6
         | F6
         | S7
         | P7
         | D7
         | F7
  deriving (Show, Read, Eq, Ord)
derivePersistField "Lvl"

data Element = EmptyElement
             | H Lvl
             | He Lvl
             | Li Lvl
             | Be Lvl
             | B Lvl
             | C Lvl
             | N Lvl
             | O Lvl
             | F Lvl
             | Ne Lvl
             | Na Lvl
             | Mg Lvl
             | Al Lvl
             | Si Lvl
             | P Lvl
             | S Lvl
             | Cl Lvl
             | Ar Lvl
             | K Lvl
             | Ca Lvl
             | Sc Lvl
             | Ti Lvl
             | V Lvl
             | Cr Lvl
             | Mn Lvl
             | Fe Lvl
             | Co Lvl
             | Ni Lvl
             | Cu Lvl
             | Zn Lvl
             | Ga Lvl
             | Ge Lvl
             | As Lvl
             | Se Lvl
             | Br Lvl
             | Kr Lvl
             | Rb Lvl
             | Sr Lvl
             | Y Lvl
             | Zr Lvl
             | Nb Lvl
             | Mo Lvl
             | Tc Lvl
             | Ru Lvl
             | Rh Lvl
             | Pd Lvl
             | Ag Lvl
             | Cd Lvl
             | In Lvl
             | Sn Lvl
             | Sb Lvl
             | Te Lvl
             | I Lvl
             | Xe Lvl
             | Cs Lvl
             | Ba Lvl
             | Lu Lvl
             | Hf Lvl
             | Ta Lvl
             | W Lvl
             | Re Lvl
             | Os Lvl
             | Ir Lvl
             | Pt Lvl
             | Au Lvl
             | Hg Lvl
             | Tl Lvl
             | Pb Lvl
             | Bi Lvl
             | Po Lvl
             | At Lvl
             | Rn Lvl
             | Fr Lvl
             | Ra Lvl
             | Lr Lvl
             | Rf Lvl
             | Db Lvl
             | Sg Lvl
             | Bh Lvl
             | Hs Lvl
             | Mt Lvl
             | Ds Lvl
             | Rg Lvl
             | Cn Lvl
             | Nh Lvl
             | Fl Lvl
             | Mc Lvl
             | Lv Lvl
             | Ts Lvl
             | Og Lvl
             | La Lvl
             | Ce Lvl
             | Pr Lvl
             | Nd Lvl
             | Pm Lvl
             | Sm Lvl
             | Eu Lvl
             | Gd Lvl
             | Tb Lvl
             | Dy Lvl
             | Ho Lvl
             | Er Lvl
             | Tm Lvl
             | Yb Lvl
             | Ac Lvl
             | Th Lvl
             | Pa Lvl
             | U Lvl
             | Np Lvl
             | Pu Lvl
             | Am Lvl
             | Cm Lvl
             | Bk Lvl
             | Cf Lvl
             | Es Lvl
             | Fm Lvl
             | Md Lvl
             | No Lvl
  deriving (Show, Read, Eq, Ord)
derivePersistField "Element"
