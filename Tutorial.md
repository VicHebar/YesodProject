# Guía para configurar Yesod.

Esta es una guía detallada con pasos sencillos para configurar una computadora con el fin de hacer uso de Yesod.
Acontinuación se enlistan las secciones que contendrá la lista:

1. Obtener e instalar Stack.
2. Stack Templates
3. Crear un Proyecto con Stack
4. Compilar nuesta primera página con yesod
    - Primera página
    - Modificando nuestra primera página
5. Nuestra segunda página
    - Una base de datos
    - Creando los tipos necesarios
5. Obtener Git
6. Github
7. Crear un repositorio en Github
9. Enlazar tu Proyecto con Github
 

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podrás encontrar le encabezado *How to install* e inmediatamente después de ese encabezado encontrarás un enlace para descargar el instalador para windows marcado como *Windows 64-bit installer* . Después de que la instalación haya finalizado lo siguiente será realizar la instalación.  
Al abrir el instalador de Stack nos permitirá seleccionar la ruta donde deseemos instalar Stack, por lo general se dejará la ruta que viene especificada por el instalador, acontinuación seleccionaremos la opción Next. En la siguiente pantalla que aparecerá nos permitirá seleccionar los componentes a instalar, por defecto vienen marcadas todas, habremos de dejarlas así y seleccionaremos la opción Install. Así al finalizar tendremos Stack instalado en la computadora, listo para ser ejecutado en cualquier linea de comando desde cualquir directorio. Para verificar esto tendremos que abrir una linea de comandos y escribir la linea stack --version, como resultado la linea de comandos nos arrojará la versión actual de stack. Para acceder a la linea de comandos utilizaremos la combinación de teclas Win + r, nos abrirá una ventana de ejecución, en ella escribiremos la palabra cmd y daremos la opción aceptar.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack están almacenados en archivos .hsfiles, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta guía usaremos el template yesod-sqlite.hsfiles

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de *crear proyectos*. Para la creación de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicación donde querramos almacenar la carpeta del proyecto, haremos esto usando la función *cd* que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la dirección a la que querramos dirijirnos, por ejemplo `C:\\Users\\Usuario> cd C:\\Users\\Usuario\\alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* será sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* será remplazado por el Template que desees usar y se usará unicamente el nombre del template, sin la terminación *.hsfiles*, en el caso de esta Guía usaremos el template de *yesod-sqlite*.  
    Una vez que se tenga escrito el comando completo y en la ubicación deseada se dará enter y comezará a preparar todo con la configuración del template elegido, al finalizar podremos leer la ultima frase como **All done** lo que nos indicará que todo se ha concluido con éxito. Después tendremos que hacer el setup de nuestro proyecto y para ello nos moveremos a la carpeta que se ha generado tras haber creado nuestro proyecto, para hacer esto haremos uso nuevamente de la función **cd** de la siguiente manera `cd mi-proyecto` donde *mi-proyecto* es el nombre que habíamos elejido previamente. Una vez en el directorio de nuestro proyecto escribiremos la siguiente instrucción `stack setup`, esta instrucción descargará el compilador en la versión que sea necesaria para el proyecto en caso de que no se encuentre ya en el sistema.  
Finalmente escribiremos la instrucción `stack build`, que compila los archivos generados anteriormente y termina de construir el minimo proyecto.

## Compilar nuesta primera página con yesod

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
Una vez hecho esto nos dirigiremos a este [directorio de GitHub](https://github.com/VicHebar/YesodProject/tree/master/src) y descargaremos la carpeta **LucidTemplates**, esta carpeta contiene un template específico para nuestro Hola Mundo, una vez desgargada la carpeta, la guardaremos en el directorio de nuestro proyecto, en la carpeta /src.  
Posterior a estos pasos nos dirigiremos al directorio de nuestro proyecto, a la archivo *./src/Handler/Home.hs*. Dentro de este archivo lo primero que haremos será sustituir todo el código que se encuentre antes de la línea que contiene *module Handler.Home where* por las siguientes líneas:  
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

## Nuestra segunda página

### Una base de datos

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

Para crear los tipos que vamos a estar usando para la creación de la base de datos contemplaremos dos nuevos tipos, los cuales serán: **Lvl** y **Element** que simplemente representarán los niveles de energía y los elementos de la tabla periódica. Para su creación primero tendremos que crear un directorio específico en el cuál iremos almacenando dichos tipos. Para ello nos dirigiremos al directorio `./src` y dentro de este directorio crearemos un nuevo directorio llamado `Models` y moveremos el archivo `./src/Model`.hs a `./src/Models/Model.hs` y dentro de este mismo directorio crearemos un archivo llamado `ModelElement.hs` en el cual definiremos nuestros tipos, el archivo contendrá lo siguiente:  
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
Y, de nuevo se encontrará en `./src/Models/ModelElement.hs`

## Github

Github es un manejador de versiones, una herramienta que nos permitirá tener un control sobre el histórico de versiones de nuestro proyecto. Además de eso, Github nos permite compartir código con distintas personas, podríamos pensar en Github como una red social de programadores. El primer paso que tomaremos será crear una cuenta en Github, y para ello accederemos a [su página](https://github.com/), una vez dentro crearemos una cuenta nueva siguiendo los pasos marcados en la página, rellenándo los campos solicitados. Una vez que esté hecha nuestra cuenta podremos empezar a crear repositorios.

## Crear un Repositorio en Github

Cuando la cuenta esté creada inmediatamente tendremos en pantlla una página con un encabezado llamado *Create a new repository*, (en caso de que al iniciar no te aparezca esta pantalla siempre puedes entrar en la opción *New*, en la sección *Repositories*), en esta pantalla lo único que ncesitas es especificar un nombre para tu repositorio después de eso especifica si tu repositorio será público oprivado, para finalizar selecciona la opción *Create Repository*.

## Enlazar tu proyecto con Github

Una vez esté creado tu repositorio el siguiente paso es enlazarlo y para ello haremos uso de Git. Trás crear el repositorio podremos
