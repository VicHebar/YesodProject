# Guia para el uso de Yesod en Linux con Postgres

Esta es una guía detallada con pasos sencillos para configurar una computadora con Linux con el fin de hacer uso de Yesod con PostgreSQL.

Acontinuación se enlistan las secciones que contendrá la lista:

1. Obtener e instalar Stack.
2. Stack Templates
3. Crear un Proyecto con Stack
4. Compilar nuesta primera página con yesod
    - Configurar nuestra base de datos
    - Primera página
    - Modificando nuestra primera página
5. Nuestra segunda página
    - Nuevas tablas para nuestra base de datos
    - Creando los tipos necesarios
    - Modificando nuestra base de datos
    - Rellenando nuestras tablas
    - Hacinedo uso de nuestras tablas.

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podrás encontrar le encabezado *How to install* e inmediatamente después de ese encabezado encontrarás dos opciones sencillas para instalar desde un sistema Unix.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack están almacenados en archivos .hsfiles, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta guía usaremos el template yesod-postgres.hsfiles

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de *crear proyectos*. Para la creación de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicación donde querramos almacenar la carpeta del proyecto, haremos esto usando la función *cd* que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la dirección a la que querramos dirijirnos, por ejemplo `> cd alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* será sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* será remplazado por el Template que desees usar y se usará unicamente el nombre del template, sin la terminación *.hsfiles*, para efectos de esta Guía usaremos el template de *yesod-postgres*.  
Una vez que se tenga escrito el comando completo y en la ubicación deseada se dará enter y comezará a preparar todo con la configuración del template elegido, al finalizar podremos leer la ultima frase como **All done** lo que nos indicará que todo se ha concluido con éxito. Después tendremos que hacer el setup de nuestro proyecto y para ello nos moveremos a la carpeta que se ha generado tras haber creado nuestro proyecto, para hacer esto haremos uso nuevamente de la función **cd** de la siguiente manera `cd mi-proyecto` donde *mi-proyecto* es el nombre que habíamos elejido previamente. Una vez en el directorio de nuestro proyecto escribiremos la siguiente instrucción `stack setup`, esta instrucción descargará el compilador en la versión que sea necesaria para el proyecto en caso de que no se encuentre ya en el sistema.  
Finalmente escribiremos la instrucción `stack build`, que compila los archivos generados anteriormente y termina de construir el minimo proyecto.

## Compilar nuesta primera página con yesod

### Configurar nuestra base de datos

Para que nuestra página web se pueda compilar de manera correcta tendremos que crear un rol y una base de datos donde se almacenarán las tablas necesarias para la página web.  
Si nos dirigimos a `mi-proyecto/config/models`, dentro de este archivo podremos echar un vistazo a las tablas que se crearán una vez esté creada nuestra base de datos. Por defecti nosotros podremos ver las siguientes lineas:  
~~~ haskell
User
    ident Text
    password Text Maybe
    UniqueUser ident
    deriving Typeable
Email
    email Text
    userId UserId Maybe
    verkey Text Maybe
    UniqueEmail email
Comment json -- Adding "json" causes ToJSON and FromJSON instances to be derived.
    message Text
    userId UserId Maybe
    deriving Eq
    deriving Show
~~~
La forma sencilla de leer esta sintaxis es, por ejemplo:  
~~~ haskell
nombre-tabla
    campo1 tipo-campo1
    campo2 tipo-campo2
    ...
    campon tipo-campon
    constrain campo
~~~
En este ejemplo podemos leer el nombre de la tabla en el encabezado sin identado, seguido por los campos (o columnas) que contendrá nuestra tabla, bajo el formato `nombre-del-campo tipo-del-campo`, y al finalizar todos los campos que tendrá nuestra tabla podremos leer los constrains (las reglas que definen el comportamiento de cada campo) que definirán a cada cmapo en caso de ser necesarios.  
Para que la aplicaión pueda ejecutarse necesitaremos una base de datos donde almacenar estas tablas y para poder verificar cuáles serán losnombres necesarios que tendremos que usar iremos a la dirección: `ToDeleteYesod/config/settings.yml` donde podremos encontrar las lineas:  
~~~
database:
  user:     "_env:YESOD_PGUSER:ToDeleteYesod"
  password: "_env:YESOD_PGPASS:ToDeleteYesod"
  host:     "_env:YESOD_PGHOST:localhost"
  port:     "_env:YESOD_PGPORT:5432"
  # See config/test-settings.yml for an override during tests
  database: "_env:YESOD_PGDATABASE:ToDeleteYesod"
  poolsize: "_env:YESOD_PGPOOLSIZE:10"
~~~
En estas lineas podremos encontrar información importante sobre la base de datos que debemos crear, primero que nada podremos leer en la linea *user* el texto *ToDeleteYesod*, que será el nombre que del rol que necesitaremos en la base de datos. El siguiente dato de interés será *password* que será la pass para el rol anterior. El ultimo dato de interés será *database* con el nombre de la base de datos que se deberá crear. Una vez identificados estos datos los modificaremos a nuestro interés de la siguiente manera:  
~~~
database:
  user:     "_env:YESOD_PGUSER:todeleteyesodu"
  password: "_env:YESOD_PGPASS:ToDeleteYesodP"
  host:     "_env:YESOD_PGHOST:localhost"
  port:     "_env:YESOD_PGPORT:5432"
  # See config/test-settings.yml for an override during tests
  database: "_env:YESOD_PGDATABASE:todeleteyesoddb"
  poolsize: "_env:YESOD_PGPOOLSIZE:10"
~~~
Acontinuación nos dirigiremos a una terminal donde podremos crear la base de datos y el rol, para ello escribiremos (en la terminal) `psql -U postgres postgres` y entraremos el prompt `postgres=#` al dar enter. Una vez aquí, crearemos el role antes especificado *todeleteyesodu* con el siguiente comando de SQL `CREATE ROLE todeleteyesodu WITH LOGIN PASSWORD 'ToDeleteYesodP';`, una vez ejecutado podremos leer *CREATE ROLE* que nos notificará que no hubo errores durante su creación, para corroborar su creacion podemos escribir el comando `\du` que nos desplegará una tabla con todos los roles creados con sus respectivos atributos, en alguno de losd registros podremos leer el nombre de nuestro role *todeleteyesodu*.  
Para crear nuestra base de datos usaremos el comando `CREATE DATABASE todeleteyesoddb;`, una vez ejecutado podremos leer *CREATE DATABASE* que, una vez más, nos notificará que no hubo errores en su creación.  
El último paso a seguir es grantizar los derechos dobre la nueva base de datos a nuestro nuevo rol, para ello usaremos el comando `GRANT ALL ON DATABASE todeleteyesoddb TO todeleteyesodu;` y al hacerlo podremos leer una vez más *GRANT*, que de igual manera nos notificará que todo estuvo en orden al ejecutar el comando. Para salir del prompt ejecutaremos `\q` que nos sacara del prompt de psql.

### Primera página

Yesod, por defecto, nos entrega una primera página compilada tras haber completado los pasos anteriores, para poder ejecutarla escribiremos la siguiente linea en una linea de comandos en el directorio raíz de nuestro proyecto,  
`stack exec -- yesod devel`  
La consola comenzará a compilar nuestro proyecto, al finalizar, en las ultimas dos líneas que imprimirá podremos leer  
~~~
Starting devel application
Devel application launched: http://localhost:port
~~~
Donde port será el puerto donde se ejecutará, al ir anuestro navegador y escribir esta ultima dirección en la barra de direcciones podremos visualizar la página que Yesod ha construido para nosotros.

### Modificando nuestra primera página

El primer cambio que le haremos a nuestra página será poder hacer un Hola mundo a partir del codigo generado por Yesod y un poco de código extra que podrás encontrar en este repositorio de GitHub. El primer paso será acceder a la carpeta de nuestro proyecto y encontrar los archivos *stack.yaml* y *package.yaml*. Primero accedamos a stack.yaml, dentro de este archivo encontremos la línea en la que se puede leer `# extra-deps:` que por lo general se encuentra en la línea 37, en esta línea quitaremos el símbolo # y el espacio, de tal manera que obtengamos `extra-deps:` daremos un enter y escribiremos las siguientes líneas:  
~~~
  - git: https://github.com/bitemyapp/esqueleto.git
    commit: 08c9b4cdf977d5bcd1baba046a007940c1940758
  - git: https://github.com/alogic0/lucid-from-html.git
    commit: 3d42b8fc45be08a0697e73441e4d28483b0cef90
~~~
De tal manera que obtendremos las siguientes líneas:  
~~~
extra-deps:
  - git: https://github.com/bitemyapp/esqueleto.git
    commit: 08c9b4cdf977d5bcd1baba046a007940c1940758
  - git: https://github.com/alogic0/lucid-from-html.git
    commit: 3d42b8fc45be08a0697e73441e4d28483b0cef90
~~~
Guardemos los cambios hechos y nos dirigiremos al siguiente archivo, package.yaml. Al acceder a este archivo ubicaremos la línea en la que se puede leer `dependencies:` generalmente en la línea 4, que es precedido por multiples dependecias bajo la sitaxis `- dependencia ver-min ver-max`, ubicaremos la ultima dependencia e inmediatamente despues de ella podremos las siguientes dependencias:  
~~~
- lucid
- lucid-from-html
- blaze-html
- blaze-builder
- blaze-markup
~~~
Una vez hecho esto nos dirigiremos a este [directorio de GitHub](https://github.com/VicHebar/YesodProject/tree/e886e75ea6d4fed1e0321ff2924c1ed7074da155/src/LucidTemplates) y descargaremos la carpeta **LucidTemplates**, esta carpeta contiene un template específico para nuestro Hola Mundo, una vez desgargada la carpeta, la guardaremos en el directorio de nuestro proyecto, en la carpeta *ToDeleteYesod/src*.  
Posterior a estos pasos nos dirigiremos al directorio de nuestro proyecto, a la archivo *ToDeleteYesod/src/Handler/Home.hs*. Dentro de este archivo lo primero que haremos será sustituir todo el código que se encuentre antes de la línea que contiene *module Handler.Home where* por las siguientes líneas:  
~~~ haskell
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
~~~
Tras haber hecho este cambio buscaremos la línea que contenga el código:
`getHomeR :: Handler Html`
Y apartir de esta línea borraremos todo el contenido del documento, obteniendo como resultado:  
~~~ haskell
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
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))
~~~
Después agregaremos la siguientes líneas bajo este código:  
~~~ haskell
getHomeR :: Handler Html
getHomeR = do
  defaultLayout $ do
    setTitle "Hola mundo!"
    toWidget . preEscapedToHtml . renderText $ homePage
~~~
Para obtener como resultado el siguiente código en *./src/Handler/Home.hs*:  
~~~ haskell
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
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))

import Lucid hiding (Html, toHtml)
import Text.Blaze.Html
import LucidTemplates.HomeTemplate

getHomeR :: Handler Html
getHomeR = do
  defaultLayout $ do
    setTitle "Hola Mundo!"
    toWidget . preEscapedToHtml . renderText $ homePage 
~~~
Posteriormente iremos al archivo *./config/routes*, donde podremos encontrar la línea  
~~~ haskell
/ HomeR GET POST
~~~
De la cual eliminaremos *POST* de tal suerte que obtengamos:  
~~~ haskell
/ HomeR GET
~~~
Una vez hechos todos estos cambios podremos verificar el resultado de la misma manera que habíamos hecho antes, escribiendo en la línea de comandos, en el directorio base de nuestro proyecto: `stack exec -- yesod devel` y esto compilará la página y nos permitirá ver el resultado en **localhost**.

## Nuestra segunda página

### Nuevas tablas para nuestra base de datos

Para crear una base de datos primero hemos de diseñar la estructura de la base de datos, para ello pensaremos en cuatro tablas que inicialmente van a contener a los clientes, algunos parámetros que los clientes deseen compartir en la página, comentarios que se deseen compartir acerca de los parámetros compartidos y Posts en los cuales se pubicarán los comentarios antes mencionados. A estas tablas las llamaremos **Customer**, **Parameter**, **Comment** y **Post** respectivamente.  
El formato de la tabla contendrá para Costumers los siguientes campos:

- ident Text
- password Text Maybe

Para Parameter será:

- par (Map Text Double)
- author (CustomerId)
- alias Text
- elements [Element]

Para Comment:

- author Customer Id
- date Time
- text Text

Para Post:

- parametro Parameter Id
- author Customer Id
- date Time
- comments [Comment]

### Creando los tipos necesarios

Para crear los tipos que vamos a estar usando para la creación de la base de datos contemplaremos dos nuevos tipos, los cuales serán: **Lvl** y **Element** que simplemente representarán los niveles de energía y los elementos de la tabla periódica. Para su creación primero tendremos que crear un directorio específico en el cuál iremos almacenando dichos tipos. Para ello nos dirigiremos al directorio `./src` y dentro de este directorio crearemos un nuevo directorio llamado `Models` y moveremos el archivo `ToDeleteYesod/src/Model.hs` a `ToDeleteYesod/src/Models/Model.hs` y dentro del mismo modificaremos el noombre del modulo de la siguiente manera:  
~~~ haskell
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")
~~~
Se hará un ligero cambio en el nombre del modulo en la linea 10 por `module Models.Model where` de tal manera que obtengamos el siguiente script:  
~~~ haskell
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
module Models.Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")
~~~
Además de este archivo deberemos modificar el archivo `ToDeleteYesod/src/Import/NoFoundations.hs` y modificar de la siguiente manera:  
~~~ haskell
{-# LANGUAGE CPP #-}
module Import.NoFoundation
    ( module Import
    ) where

import ClassyPrelude.Yesod   as Import
import Model                 as Import
import Settings              as Import
import Settings.StaticFiles  as Import
import Yesod.Auth            as Import
import Yesod.Core.Types      as Import (loggerSet)
import Yesod.Default.Config2 as Import
~~~
Por:  
~~~ haskell
{-# LANGUAGE CPP #-}
module Import.NoFoundation
    ( module Import
    ) where

import ClassyPrelude.Yesod   as Import
import Models.Model          as Import
import Settings              as Import
import Settings.StaticFiles  as Import
import Yesod.Auth            as Import
import Yesod.Core.Types      as Import (loggerSet)
import Yesod.Default.Config2 as Import
~~~
Todos los cambios anteriores se deben a que hemos movido el arachivo *Model.hs* de su ibicación original con el fin de tener un ,ejor control de los archivos que se agregarán posteriormente, sin embargo al cambiar su ubicación el resto de documentos que lo importaban no lo encontrarían, es por ello que en cad aarchivo se tuvo que modificar la ubicación donde lo buscaría al importarlo.  
Ahora, dentro del directorio `ToDeleteYesod/src/Models` crearemos un archivo llamado `ModelElement.hs` en el cual definiremos nuestros tipos, el archivo contendrá lo siguiente:  
~~~ haskell
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
~~~
Y, de nuevo se encontrará en `./src/Models/ModelElement.hs`.

### Modificando nuestra base de datos

Una vez creados los tipos anteriores podremos, por fin, modificar las tablas que el template *yesod-postgres* por defecto nos da para poder agregar las tablas que son de nuestro interes. Para ello nos dirigiremos al archivo el cual anteriormente habíamos podido darle un vistazo, *models*, dentro de este archivo podremos ver el contenido de las tablas anteriores que en esta ocasión sustituiremos por nuestras nuevas tablas. Para ello sustituiremos el contenido del archivo por el siguiente:  
~~~
Customer
    ident Text
    password Text Maybe
    UniqueUser ident
    deriving Typeable
Parameter
    par (Map Text Double)
    author (CustomerId)
    alias Text
    elements [Models.ModelElement.Element]
Post
    p ParameterId
    a CustomerId
    d UTCTime
    c [Comment]
Comment
    a CustomerId
    d UTCTime
    t Text
~~~
Este nuevo codigo define las nuevas tablas que anteriormente habíamos discutido en la sección **Nuevas tablas para nuestra base de datos**. Además de modificar este archivo tendremos que agregar los imports necesarios para nuestro nuevo model **ModelElement**. Nos dirigiremos a el archivo *Model.hs* y en este archivo incluiremos un nuevo import `import Models.ModelElement`.  
Al haber cambiado nuestras tablas algunas porciones de nuestro código generado por yesod-postgres quedará inútil o se tendrá que modificar, la primera modificación que se hará será al archivo *Foundation.hs* que se encuentra en `ToDeleteYesod/src/Foundation.hs`, dentro de este archivo vamos a buscar todas las instancias de la palabra *user* y las remplazaremos por *customer* y en los casos donde se encuentre escrito *User* será sustituido por *Customer*. El siguiente archivo a modificar será el archivo *Profile.hs* que se encuentra alojado en `ToDeleteYesod/src/Handler/Profile.hs`, en este documento de igual manera sustituiremos todos los *user* por *costumer*. Ahora dentro del archivo *Comment.hs* en el directorio `ToDeleteYesod/src/Handler/Comment.hs`, modificaremos todo el contenido de el documento de:  
~~~ haskell
module Handler.Comment where

import Import

postCommentR :: Handler Value
postCommentR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    comment <- (requireJsonBody :: Handler Comment)

    -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
    maybeCurrentUserId <- maybeAuthId
    let comment' = comment { commentUserId = maybeCurrentUserId }

    insertedComment <- runDB $ insertEntity comment'
    returnJson insertedComment
~~~
Por:  
~~~ haskell
module Handler.Comment where

import Import

postCommentR :: Handler Value
postCommentR = Prelude.undefined
~~~
Y el ultimo archivo a modificar será *profile.hamlet* que se encuentra el `ToDelete/Templates/profile.hamlet`, en este documento realizaremos el mismo proceso que en los documentos anteriores.  
Por ultimo y con la finalidad de que nuestro proyecto compile con normalidad será necesario reiniciar la base de datos, para ello iremos a nuestro prompt de psql escribiremos la sentencia sql `DROP DATABASE todeleteyesoddb;`, esta sentencia eliminara la base de datos, posterior, la volveremos a crear con la sentencia `CREATE DATABASE todeleteyesoddb;`, una vez hecho esto podremos salir del prompt (con el comando `\q`) y compilar nuestro proyecto con `stack exec -- yesod devel`, ir a nuestro **localhost** y corroborar que todo se encuentre en orden.

### Rellenando nuestras tablas

Una vez hechos los pasos anteriores podremos ir al prompt de psql y verificar que nuestras tablas fueron creadas como se suponía, para ello entraremos al prompt (con `psql -U postgres postgres`) y una vez allí nos conectaremos a nuestra base de datos con el comando `\c todeleteyesoddb`, una vez establecida la conección podremos leer el mensaje **You are now connected to database "todeleteyesoddb" as user "postgres"** seguido del prompt **todeleteyesoddb=#**, aquí ejecutaremos el comando `\dt` que nos mostrará una tabla con todas las tablas creadas en esa base de datos.  
Para hacer uso de nuestras nuevas tablas las rellenaremos con información, para ello crearemos un Script que nos rellene la base de datos por nosotros.  
Crearemos un archivo llamado *PopulateDB.hs* aunque en realidad el nombre nos es indiferente, dentro de este archivo comenzaremos por llamar los **Nombre de los encabezados** y los imports además de nombrar al módulo de la siguiente manera:  
~~~ haskell
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
~~~
Ahora definiremos una función que nos permitirá generar los registros en la base de datos, a falta de imaginación, llamaremos a esta función *script*, dicha función será de tipo condtante `IO ()` para poder hacer uso de la secuencialidad de *Monad*, dentro de esta función usaremos la función *db* para poder hacer las incersiones, así, nuestra función quedaría en un inicio definida de la manera:  
~~~ haskell
script :: IO ()
script = db $ do
~~~
Lo primero que haremos será extraer la hora actual, para ello usaremos `getCurrentTime` ya que posteriormente la usaremos. EL siguiente paso será hacer las incersiones para *Customer*, haremos 3 de ellas rellenando los parametros necesarios, y analogamente rellenaremos con tres registros la tabla *Parameter* obteniendo:  
~~~ haskell
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
~~~
Dado a que usaremos objetos de Comment dentro de los registros de Post, primero crearemos los objetos por separado y después haremos la incersion de los objetos creados por separado.  
~~~ haskell
  let
    comVic = Comment {
      commentA = victor,
      commentD = time,
      commentT = "This is a comment from Vic"}
    comDani = Comment {
      commentA = daniel,
      commentD = time,
      commentT = "This is a comment from Daniel"}
    comAlbert = Comment {
      commentA = alberto,
      commentD = time,
      commentT = "This is a comment from Alberto"}
  _ <- insert $ comVic
  _ <- insert $ comDani
  _ <- insert $ comAlbert
~~~
De esta manera cuando creemos los objetos de Post para poder hacer la incersion podremos asignarel una lista de objetos existentes dentro de la base de datos Comment como se muestra a continuación:  
~~~ haskell
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
~~~
Y al final (Dado a que nuestra función es tipo IO ()) tendremos que regresar algo de tipo IO (), para ello usaremos la función `return ()`, tendiendo el script completo de la siguiente manera:  
~~~ haskell
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
~~~
Para poder ejecutar este script y poder rellenar nuestra base de datos tendremos que logear este script en ghci. Iremos desde una terminal a la raiz de nuestro proyecto, en nuestro caso `ToDeleteYesod/`, una vez allí, ejectutaremos el comando `stack ghci`, tras terminar de cargar todo lo que tenga que cargar escribiremos `:l src/Models/PopulateDB.hs` lo que lodeará nuestro módulo y podremos ejecutar la función script, para ellos escribiremos *script*, tras haber ejecutado la función podremos verificar que las tablas se rellenaron on exito desde el prompt de psql, para salir de ghci basta con ejecutar `:q`, una vez en el prompt de psql nos conectaremos con la base de datos y ejecutaremos la sentencia SQL `SELECT * FROM Customer;`, nos desplegará una tabla con todos los registros que posteriormente hemos introducido.
