# Guía para configurar Yesod.

Esta es una guía detallada con pasos sencillos para configurar una computadora con el fin de hacer uso de Yesod.
Acontinuación se enlistan las secciones que contendrá la lista:

1. Obtener e instalar Stack.
2. Obtener e Instalar Postgres
3. Stack Templates
4. Crear un Proyecto con Stack
5. Obtener Git
6. Github
7. Crear un repositorio en Github
8. Enlazar tu Proyecto con Github

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podrás encontrar le encabezado **How to install** e inmediatamente después de ese encabezado encontrarás un enlace para descargar el instalador para windows marcado como **Windows 64-bit installer** . Después de que la instalación haya finalizado lo siguiente será realizar la instalación.  
Al abrir el instalador de Stack nos permitirá seleccionar la ruta donde deseemos instalar Stack, por lo general se dejará la ruta que viene especificada por el instalador, acontinuación seleccionaremos la opción *Next*. En la siguiente pantalla que aparecerá nos permitirá seleccionar los componentes a instalar, por defecto vienen marcadas todas, habremos de dejarlas así y seleccionaremos la opción *Install*. Así al finalizar tendremos Stack instalado en la computadora, listo para ser ejecutado en cualquier linea de comando desde cualquir directorio. Para verificar esto tendremos que abrir una linea de comandos y escribir la linea *stack --version*, como resultado la linea de comandos nos arrojará la versión actual de stack. Para acceder a la linea de comandos utilizaremos la combinación de teclas Win + r, nos abrirá una ventana de ejecución, en ella escribiremos la palabra *cmd* y daremos la opción *aceptar*.

## Obtener e instalar Postgres

Para obtener postgres tendrenos que dirigirnos a [su página](postgresql.org), una vez allí nos dirigiremos a la opción **Descargar ->** y una vez allí encontraremos un encabezado llamado **Binary packages** donde encontraremos enlistados todos los sistemas operativos, una vez localizado el sistema operativo sobre el cual estamos trabajando lo seleccionaremos y nos redirigirá a una nueva página donde encontraremos nuevamente un enlace marcado como **Download the installer**, este nnos llevará nuevamente a una página con diferentes versiones de postgresql, en esta guía se hará uso de la versión 10.11, selecciona el enlace de descarga que se acople a tu versión de sistema operativo, esto iniciará la descarga del instalador.  
A iniciar el instalador seguiremos las instrucciónes en pantalla y al finalizar habrá instalado postgresql. Además de esto, al finalizar nos dará la opción de instalar más utilerías, de las cuáles seleccionaremos **EDB Language Pack, Npgsql, pgBouncer, pgJDBC, psqlODBC y PostgreSQL**, recalcando que la opción de PostgreSQL será la versión marcada como ya descargada. Nuevamente se seguirán las instrucciónes en pantalla y finalizará la instalación.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack están almacenados en archivos *.hsfiles*, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta guía usaremos el template *yesod-postgres.hsfiles*

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de **crear proyectos**. Para la creación de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicación donde querramos almacenar la carpeta del proyecto, haremos esto usando la función **cd** que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la dirección a la que querramos dirijirnos, por ejemplo `C:\\Users\\Usuario> cd C:\\Users\\Usuario\\alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* será sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* será remplazado por el Template que desees usar y se usará unicamente el nombre del template, sin la terminació *.hsfiles*, en el caso de esta Guía usaremos el template de **yesod-postgres**.  
Una vez que se tenga escrito el comando completo y en la ubicación deseada se dará enter y comezará a preparar todo con la configuración del template elegido, al finalizar podremos leer la ultima frase como **All done** lo que nos indicará que todo se ha concluido con éxito. Después tendremos que hacer el setup de nuestro proyecto y para ello nos moveremos a la carpeta que se ha generado tras haber creado nuestro proyecto, para hacer esto haremos uso nuevamente de la función **cd** de la siguiente manera `cd mi-proyecto` donde *mi-proyecto* es el nombre que habíamos elejido previamente. Una vez en el directorio de nuestro proyecto escribiremos la siguiente instrucción `stack setup`, esta instrucción descargará el compilador en la versión que sea necesaria para el proyecto en caso de que no se encuentre ya en el sistema.  
Finalmente escribiremos la instrucción `stack build`, que compila los archivos generados anteriormente y termina de construir el minimo proyecto.

## Github

Github es un manejador de versiones, una herramienta que nos permitirá tener un control sobre el histórico de versiones de nuestro proyecto. Además de eso, Github nos permite compartir código con distintas personas, podríamos pensar en Github como una red social de programadores. El primer paso que tomaremos será crear una cuenta en Github, y para ello accederemos a [su página](https://github.com/), una vez dentro crearemos una cuenta nueva siguiendo los pasos marcados en la página, rellenándo los campos solicitados. Una vez que esté hecha nuestra cuenta podremos empezar a crear repositorios.

## Crear un Repositorio en Github

Cuando la cuenta esté creada inmediatamente tendremos en pantlla una página con un encabezado llamado **Create a new repository**, (en caso de que al iniciar no te aparezca esta pantalla siempre puedes entrar en la opción **New**, en la sección **Repositories**), en esta pantalla lo único que ncesitas es especificar un nombre para tu repositorio después de eso especifica si tu repositorio será público oprivado, para finalizar selecciona la opción **Create Repository**.

## Enlazar tu proyecto con Github

Una vez esté creado tu repositorio el siguiente paso es enlazarlo y para ello haremos uso de Git. Trás crear el repositorio podremos 
