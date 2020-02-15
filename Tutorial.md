# Guía para configurar Yesod.

Esta es una guía detallada con pasos sencillos para configurar una computadora con el fin de hacer uso de Yesod.
Acontinuación se enlistan las secciones que contendrá la lista:

1. Obtener e instalar Stack.
2. Stack Templates
3. Crear un Proyecto con Stack
4. Compilar nuesta primera página con yesod
    - Primera página
    - Modificando nuestra primera página
5. Obtener Git
6. Github
7. Crear un repositorio en Github
9. Enlazar tu Proyecto con Github
 

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podrás encontrar le encabezado **How to install** e inmediatamente después de ese encabezado encontrarás un enlace para descargar el instalador para windows marcado como **Windows 64-bit installer** . Después de que la instalación haya finalizado lo siguiente será realizar la instalación.  
Al abrir el instalador de Stack nos permitirá seleccionar la ruta donde deseemos instalar Stack, por lo general se dejará la ruta que viene especificada por el instalador, acontinuación seleccionaremos la opción *Next*. En la siguiente pantalla que aparecerá nos permitirá seleccionar los componentes a instalar, por defecto vienen marcadas todas, habremos de dejarlas así y seleccionaremos la opción *Install*. Así al finalizar tendremos Stack instalado en la computadora, listo para ser ejecutado en cualquier linea de comando desde cualquir directorio. Para verificar esto tendremos que abrir una linea de comandos y escribir la linea *stack --version*, como resultado la linea de comandos nos arrojará la versión actual de stack. Para acceder a la linea de comandos utilizaremos la combinación de teclas Win + r, nos abrirá una ventana de ejecución, en ella escribiremos la palabra *cmd* y daremos la opción *aceptar*.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack están almacenados en archivos *.hsfiles*, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta guía usaremos el template *yesod-sqlite.hsfiles*

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de **crear proyectos**. Para la creación de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicación donde querramos almacenar la carpeta del proyecto, haremos esto usando la función **cd** que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la dirección a la que querramos dirijirnos, por ejemplo `C:\\Users\\Usuario> cd C:\\Users\\Usuario\\alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* será sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* será remplazado por el Template que desees usar y se usará unicamente el nombre del template, sin la terminació *.hsfiles*, en el caso de esta Guía usaremos el template de **yesod-sqlite**.  
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

El primer cambio que le haremos a nuestra página será poder hacer un *Hola mundo* a partir del codigo generado por Yesod y un poco de código extra que podrás encontrar en este repositorio de GitHub. El primer paso será acceder a la carpeta de nuestro proyecto y encontrar los archivos **stack.yaml** y **package.yaml**. Primero accedamos a *stack.yaml*, dentro de este archivo encontremos la línea en la que se puede leer *# extra-deps:* que por lo general se encuentra en la línea 37, en esta línea quitaremos el símbolo *#* y el espacio, de tal manera que obtengamos *extra-deps:* daremos un enter y escribiremos las siguientes líneas:  
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
Guardemos los cambios hechos y nos dirigiremos al siguiente archivo, *package.yaml*. Al acceder a este archivo ubicaremos la línea en la que se puede leer *dependencies:* generalmente en la línea 4, que es precedido por multiples dependecias bajo la sitaxis *- dependencia ver-min ver-max*, ubicaremos la ultima dependencia e inmediatamente despues de ella podremos las siguientes dependencias:  
~~~
- lucid
- lucid-from-html
- blaze-html
- blaze-builder
- blaze-markup
~~~
Una vez hecho esto nos dirigiremos a este [directorio de GitHub](https://github.com/VicHebar/YesodProject/tree/master/src) y descargaremos la carpeta **LucidTemplates**, esta carpeta contiene un template específico para nuestro *Hola Mundo*, una vez desgargada la carpeta, la guardaremos en el directorio de nuestro proyecto, en la carpeta */src*.  
Posterior a estos pasos nos dirigiremos al directorio de nuestro proyecto, a la archivo **./src/Handler/Home.hs**. Dentro de este archivo lo primero que haremos será sustituir todo el código que se encuentre antes de la línea que contiene **module Handler.Home where** por las siguientes líneas:  
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
~~~
## Github

Github es un manejador de versiones, una herramienta que nos permitirá tener un control sobre el histórico de versiones de nuestro proyecto. Además de eso, Github nos permite compartir código con distintas personas, podríamos pensar en Github como una red social de programadores. El primer paso que tomaremos será crear una cuenta en Github, y para ello accederemos a [su página](https://github.com/), una vez dentro crearemos una cuenta nueva siguiendo los pasos marcados en la página, rellenándo los campos solicitados. Una vez que esté hecha nuestra cuenta podremos empezar a crear repositorios.

## Crear un Repositorio en Github

Cuando la cuenta esté creada inmediatamente tendremos en pantlla una página con un encabezado llamado **Create a new repository**, (en caso de que al iniciar no te aparezca esta pantalla siempre puedes entrar en la opción **New**, en la sección **Repositories**), en esta pantalla lo único que ncesitas es especificar un nombre para tu repositorio después de eso especifica si tu repositorio será público oprivado, para finalizar selecciona la opción **Create Repository**.

## Enlazar tu proyecto con Github

Una vez esté creado tu repositorio el siguiente paso es enlazarlo y para ello haremos uso de Git. Trás crear el repositorio podremos 


