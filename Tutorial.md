# Gu�a para configurar Yesod.

Esta es una gu�a detallada con pasos sencillos para configurar una computadora con el fin de hacer uso de Yesod.
Acontinuaci�n se enlistan las secciones que contendr� la lista:

1. Obtener e instalar Stack.
2. Stack Templates
3. Crear un Proyecto con Stack
4. Compilar nuesta primera p�gina con yesod
    - Primera p�gina
    - Modificando nuestra primera p�gina
5. Obtener Git
6. Github
7. Crear un repositorio en Github
9. Enlazar tu Proyecto con Github
 

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podr�s encontrar le encabezado **How to install** e inmediatamente despu�s de ese encabezado encontrar�s un enlace para descargar el instalador para windows marcado como **Windows 64-bit installer** . Despu�s de que la instalaci�n haya finalizado lo siguiente ser� realizar la instalaci�n.  
Al abrir el instalador de Stack nos permitir� seleccionar la ruta donde deseemos instalar Stack, por lo general se dejar� la ruta que viene especificada por el instalador, acontinuaci�n seleccionaremos la opci�n *Next*. En la siguiente pantalla que aparecer� nos permitir� seleccionar los componentes a instalar, por defecto vienen marcadas todas, habremos de dejarlas as� y seleccionaremos la opci�n *Install*. As� al finalizar tendremos Stack instalado en la computadora, listo para ser ejecutado en cualquier linea de comando desde cualquir directorio. Para verificar esto tendremos que abrir una linea de comandos y escribir la linea *stack --version*, como resultado la linea de comandos nos arrojar� la versi�n actual de stack. Para acceder a la linea de comandos utilizaremos la combinaci�n de teclas Win + r, nos abrir� una ventana de ejecuci�n, en ella escribiremos la palabra *cmd* y daremos la opci�n *aceptar*.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack est�n almacenados en archivos *.hsfiles*, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta gu�a usaremos el template *yesod-sqlite.hsfiles*

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de **crear proyectos**. Para la creaci�n de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicaci�n donde querramos almacenar la carpeta del proyecto, haremos esto usando la funci�n **cd** que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la direcci�n a la que querramos dirijirnos, por ejemplo `C:\\Users\\Usuario> cd C:\\Users\\Usuario\\alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* ser� sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* ser� remplazado por el Template que desees usar y se usar� unicamente el nombre del template, sin la terminaci� *.hsfiles*, en el caso de esta Gu�a usaremos el template de **yesod-sqlite**.  
Una vez que se tenga escrito el comando completo y en la ubicaci�n deseada se dar� enter y comezar� a preparar todo con la configuraci�n del template elegido, al finalizar podremos leer la ultima frase como **All done** lo que nos indicar� que todo se ha concluido con �xito. Despu�s tendremos que hacer el setup de nuestro proyecto y para ello nos moveremos a la carpeta que se ha generado tras haber creado nuestro proyecto, para hacer esto haremos uso nuevamente de la funci�n **cd** de la siguiente manera `cd mi-proyecto` donde *mi-proyecto* es el nombre que hab�amos elejido previamente. Una vez en el directorio de nuestro proyecto escribiremos la siguiente instrucci�n `stack setup`, esta instrucci�n descargar� el compilador en la versi�n que sea necesaria para el proyecto en caso de que no se encuentre ya en el sistema.  
Finalmente escribiremos la instrucci�n `stack build`, que compila los archivos generados anteriormente y termina de construir el minimo proyecto.

## Compilar nuesta primera p�gina con yesod

### Primera p�gina

Yesod, por defecto, nos entrega una primera p�gina compilada tras haber completado los pasos anteriores, para poder ejecutarla escribiremos la siguiente linea en una linea de comandos en el directorio ra�z de nuestro proyecto,  
`stack exec -- yesod devel`  
La consola comenzar� a compilar nuestro proyecto, al finalizar, en las ultimas dos l�neas que imprimir� podremos leer  
~~~
Starting devel application
Devel application launched: http://localhost:port
~~~
Donde port ser� el puerto donde se ejecutar�, al ir anuestro navegador y escribir esta ultima direcci�n en la barra de direcciones podremos visualizar la p�gina que Yesod ha construido para nosotros.

### Modificando nuestra primera p�gina

El primer cambio que le haremos a nuestra p�gina ser� poder hacer un *Hola mundo* a partir del codigo generado por Yesod y un poco de c�digo extra que podr�s encontrar en este repositorio de GitHub. El primer paso ser� acceder a la carpeta de nuestro proyecto y encontrar los archivos **stack.yaml** y **package.yaml**. Primero accedamos a *stack.yaml*, dentro de este archivo encontremos la l�nea en la que se puede leer *# extra-deps:* que por lo general se encuentra en la l�nea 37, en esta l�nea quitaremos el s�mbolo *#* y el espacio, de tal manera que obtengamos *extra-deps:* daremos un enter y escribiremos las siguientes l�neas:  
~~~
  - git: https://github.com/bitemyapp/esqueleto.git
    commit: 08c9b4cdf977d5bcd1baba046a007940c1940758
  - git: https://github.com/alogic0/lucid-from-html.git
    commit: 3d42b8fc45be08a0697e73441e4d28483b0cef90
~~~
De tal manera que obtendremos las siguientes l�neas:  
~~~
extra-deps:
  - git: https://github.com/bitemyapp/esqueleto.git
    commit: 08c9b4cdf977d5bcd1baba046a007940c1940758
  - git: https://github.com/alogic0/lucid-from-html.git
    commit: 3d42b8fc45be08a0697e73441e4d28483b0cef90
~~~
Guardemos los cambios hechos y nos dirigiremos al siguiente archivo, *package.yaml*. Al acceder a este archivo ubicaremos la l�nea en la que se puede leer *dependencies:* generalmente en la l�nea 4, que es precedido por multiples dependecias bajo la sitaxis *- dependencia ver-min ver-max*, ubicaremos la ultima dependencia e inmediatamente despues de ella podremos las siguientes dependencias:  
~~~
- lucid
- lucid-from-html
- blaze-html
- blaze-builder
- blaze-markup
~~~
Una vez hecho esto nos dirigiremos a este [directorio de GitHub](https://github.com/VicHebar/YesodProject/tree/master/src) y descargaremos la carpeta **LucidTemplates**, esta carpeta contiene un template espec�fico para nuestro *Hola Mundo*, una vez desgargada la carpeta, la guardaremos en el directorio de nuestro proyecto, en la carpeta */src*.  
Posterior a estos pasos nos dirigiremos al directorio de nuestro proyecto, a la archivo **./src/Handler/Home.hs**. Dentro de este archivo lo primero que haremos ser� sustituir todo el c�digo que se encuentre antes de la l�nea que contiene **module Handler.Home where** por las siguientes l�neas:  
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
Tras haber hecho este cambio buscaremos la l�nea que contenga el c�digo:  
`getHomeR :: Handler Html`
Y apartir de esta l�nea borraremos todo el contenido del documento, obteniendo como resultado:  
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
Despu�s agregaremos la siguientes l�neas bajo este c�digo:  
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

Github es un manejador de versiones, una herramienta que nos permitir� tener un control sobre el hist�rico de versiones de nuestro proyecto. Adem�s de eso, Github nos permite compartir c�digo con distintas personas, podr�amos pensar en Github como una red social de programadores. El primer paso que tomaremos ser� crear una cuenta en Github, y para ello accederemos a [su p�gina](https://github.com/), una vez dentro crearemos una cuenta nueva siguiendo los pasos marcados en la p�gina, rellen�ndo los campos solicitados. Una vez que est� hecha nuestra cuenta podremos empezar a crear repositorios.

## Crear un Repositorio en Github

Cuando la cuenta est� creada inmediatamente tendremos en pantlla una p�gina con un encabezado llamado **Create a new repository**, (en caso de que al iniciar no te aparezca esta pantalla siempre puedes entrar en la opci�n **New**, en la secci�n **Repositories**), en esta pantalla lo �nico que ncesitas es especificar un nombre para tu repositorio despu�s de eso especifica si tu repositorio ser� p�blico oprivado, para finalizar selecciona la opci�n **Create Repository**.

## Enlazar tu proyecto con Github

Una vez est� creado tu repositorio el siguiente paso es enlazarlo y para ello haremos uso de Git. Tr�s crear el repositorio podremos 


