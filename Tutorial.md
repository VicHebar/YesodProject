# Gu�a para configurar Yesod.

Esta es una gu�a detallada con pasos sencillos para configurar una computadora con el fin de hacer uso de Yesod.
Acontinuaci�n se enlistan las secciones que contendr� la lista:

1. Obtener e instalar Stack.
2. Obtener e Instalar Postgres
3. Stack Templates
4. Crear un Proyecto con Stack
5. Obtener Git
6. Github
7. Crear un repositorio en Github
8. Enlazar tu Proyecto con Github

## Obtener e instalar Stack

El primer paso a seguir es obtener Stack y para ello tendremos que dirigirnos a una explorador e ingresar a [la pagina de Stack](www.haskellstack.org) en donde podr�s encontrar le encabezado **How to install** e inmediatamente despu�s de ese encabezado encontrar�s un enlace para descargar el instalador para windows marcado como **Windows 64-bit installer** . Despu�s de que la instalaci�n haya finalizado lo siguiente ser� realizar la instalaci�n.  
Al abrir el instalador de Stack nos permitir� seleccionar la ruta donde deseemos instalar Stack, por lo general se dejar� la ruta que viene especificada por el instalador, acontinuaci�n seleccionaremos la opci�n *Next*. En la siguiente pantalla que aparecer� nos permitir� seleccionar los componentes a instalar, por defecto vienen marcadas todas, habremos de dejarlas as� y seleccionaremos la opci�n *Install*. As� al finalizar tendremos Stack instalado en la computadora, listo para ser ejecutado en cualquier linea de comando desde cualquir directorio. Para verificar esto tendremos que abrir una linea de comandos y escribir la linea *stack --version*, como resultado la linea de comandos nos arrojar� la versi�n actual de stack. Para acceder a la linea de comandos utilizaremos la combinaci�n de teclas Win + r, nos abrir� una ventana de ejecuci�n, en ella escribiremos la palabra *cmd* y daremos la opci�n *aceptar*.

## Obtener e instalar Postgres

Para obtener postgres tendrenos que dirigirnos a [su p�gina](postgresql.org), una vez all� nos dirigiremos a la opci�n **Descargar ->** y una vez all� encontraremos un encabezado llamado **Binary packages** donde encontraremos enlistados todos los sistemas operativos, una vez localizado el sistema operativo sobre el cual estamos trabajando lo seleccionaremos y nos redirigir� a una nueva p�gina donde encontraremos nuevamente un enlace marcado como **Download the installer**, este nnos llevar� nuevamente a una p�gina con diferentes versiones de postgresql, en esta gu�a se har� uso de la versi�n 10.11, selecciona el enlace de descarga que se acople a tu versi�n de sistema operativo, esto iniciar� la descarga del instalador.  
A iniciar el instalador seguiremos las instrucci�nes en pantalla y al finalizar habr� instalado postgresql. Adem�s de esto, al finalizar nos dar� la opci�n de instalar m�s utiler�as, de las cu�les seleccionaremos **EDB Language Pack, Npgsql, pgBouncer, pgJDBC, psqlODBC y PostgreSQL**, recalcando que la opci�n de PostgreSQL ser� la versi�n marcada como ya descargada. Nuevamente se seguir�n las instrucci�nes en pantalla y finalizar� la instalaci�n.

## Stack Templates

Los Templates de Stack son plantillas para desarrollar proyectos de determinados tipos o estilos, puede o no agregarse un template a un proyecto. La finalidad de usar un template es facilitar el trabajo usando ciertas pautas establecidas para proyectos de un mismo tipo. Los templates de stack est�n almacenados en archivos *.hsfiles*, puedes verificar los templates para proyectos de stack en [este repositorio de github](https://github.com/commercialhaskell/stack-templates), para efectos de esta gu�a usaremos el template *yesod-postgres.hsfiles*

## Crear un Proyecto con Stack

Una vez que tenemos Stack instalado en la computadora podremos empezar a trabajar y para ello hemos de **crear proyectos**. Para la creaci�n de proyectos en stack hemos de utilizar la consola de comandos, al abrir una consola de comandos nos dirigiremos a la hubicaci�n donde querramos almacenar la carpeta del proyecto, haremos esto usando la funci�n **cd** que ya nos provee la consola de comandos, al escribir cd, un espacio, y posterior la direcci�n a la que querramos dirijirnos, por ejemplo `C:\\Users\\Usuario> cd C:\\Users\\Usuario\\alguna_Direccion`.  
Una vez en el directorio deseado ejecutaremos el comando `stack new mi-proyecto algun-Template`, donde *mi-proyecto* ser� sustituido con el nombre que desees darle a tu nuevo proyecto y *algun-Template* ser� remplazado por el Template que desees usar y se usar� unicamente el nombre del template, sin la terminaci� *.hsfiles*, en el caso de esta Gu�a usaremos el template de **yesod-postgres**.  
Una vez que se tenga escrito el comando completo y en la ubicaci�n deseada se dar� enter y comezar� a preparar todo con la configuraci�n del template elegido, al finalizar podremos leer la ultima frase como **All done** lo que nos indicar� que todo se ha concluido con �xito. Despu�s tendremos que hacer el setup de nuestro proyecto y para ello nos moveremos a la carpeta que se ha generado tras haber creado nuestro proyecto, para hacer esto haremos uso nuevamente de la funci�n **cd** de la siguiente manera `cd mi-proyecto` donde *mi-proyecto* es el nombre que hab�amos elejido previamente. Una vez en el directorio de nuestro proyecto escribiremos la siguiente instrucci�n `stack setup`, esta instrucci�n descargar� el compilador en la versi�n que sea necesaria para el proyecto en caso de que no se encuentre ya en el sistema.  
Finalmente escribiremos la instrucci�n `stack build`, que compila los archivos generados anteriormente y termina de construir el minimo proyecto.

## Github

Github es un manejador de versiones, una herramienta que nos permitir� tener un control sobre el hist�rico de versiones de nuestro proyecto. Adem�s de eso, Github nos permite compartir c�digo con distintas personas, podr�amos pensar en Github como una red social de programadores. El primer paso que tomaremos ser� crear una cuenta en Github, y para ello accederemos a [su p�gina](https://github.com/), una vez dentro crearemos una cuenta nueva siguiendo los pasos marcados en la p�gina, rellen�ndo los campos solicitados. Una vez que est� hecha nuestra cuenta podremos empezar a crear repositorios.

## Crear un Repositorio en Github

Cuando la cuenta est� creada inmediatamente tendremos en pantlla una p�gina con un encabezado llamado **Create a new repository**, (en caso de que al iniciar no te aparezca esta pantalla siempre puedes entrar en la opci�n **New**, en la secci�n **Repositories**), en esta pantalla lo �nico que ncesitas es especificar un nombre para tu repositorio despu�s de eso especifica si tu repositorio ser� p�blico oprivado, para finalizar selecciona la opci�n **Create Repository**.

## Enlazar tu proyecto con Github

Una vez est� creado tu repositorio el siguiente paso es enlazarlo y para ello haremos uso de Git. Tr�s crear el repositorio podremos 
