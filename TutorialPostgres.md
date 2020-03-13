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
Una vez hecho esto nos dirigiremos a este [directorio de GitHub](https://github.com/VicHebar/YesodProject/tree/master/src) y descargaremos la carpeta **LucidTemplates**, esta carpeta contiene un template específico para nuestro Hola Mundo, una vez desgargada la carpeta, la guardaremos en el directorio de nuestro proyecto, en la carpeta *ToDeleteYesod/src*.  
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

-- Define our data that will be used for creating the form.
data FileForm = FileForm
    { fileInfo :: FileInfo
    , fileDescription :: Text
    }
~~~
Después agregaremos la siguientes líneas bajo este código:  
~~~ haskell
getHomeR :: Handler Html
getHomeR = do
  render <- getUrlRender
  meval <- maybeAuth
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

-- Define our data that will be used for creating the form.
data FileForm = FileForm
    { fileInfo :: FileInfo
    , fileDescription :: Text
    }

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
  render <- getUrlRender
  meval <- maybeAuth
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
Una vez hechos todos estos cambios podremos verificar el resultado de la misma manera anterior, escribiendo en la línea de comandos, en el directorio base de nuestro proyecto: `stack exec -- yesod devel` y esto compilará la página y nos permitirá ver el resultado en **localhost**.

