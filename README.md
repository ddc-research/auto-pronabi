# Automatic Production Report - PRONABI Team (English)

This repository contains the necessary code to generate automated production reports for the PRONABI Transfers team at the Directorate of Drug Control and Illegal Crops.

These reports are generated using [Quarto](https://quarto.org/). Once generated, they are sent by email to specific recipients using the R package `{blastula}`(https://github.com/rstudio/blastula). This workflow has been automated to run every Thursday at noon using [Github Actions](https://github.com/features/actions).

To ensure secure operation, the following environmental variables have been implemented:

- `APPSHEET_APP_ID`: ID of a Google Appsheet application. Used to fetch data in `report.qmd`.
- `APPSHEET_APP_ACCESS_KEY`: Access key for a Google Appsheet application. Used to fetch data in `report.qmd`.
- `GMAIL_USER_FROM`: Email address of the user sending the email.
- `GMAIL_USER_NAME`: User's name sending the email. Although implemented, it seems to have no effect.
- `GMAIL_USER_TO`: Email addresses of users who will receive the email. It can be a single email or multiple emails separated by a comma and a space (`, `). If there are multiple recipients, they must be specified within a single text variable (example: `"email1@example.com, email2@example.com, email3@example.com"`)
- `BLASTULA_EMAIL_CREDS`: Text generated when using `blastula::create_smtp_creds_file()`. Typically, using this function generates a text file in the working directory. The content of that file has been taken for security. Now, the same file is manually created by reading it from this environmental variable within `script.R`.


# Reporte automático de producción - Equipo PRONABI (Español)

Este repositorio contiene el código necesario para producir reportes automatizados de la producción del equipo de Transferencias a PRONABI en la Dirección de Control de Drogas y Cultivos Ilegales.

Estos reportes se generan usando [Quarto](https://quarto.org/). Una vez generados, se envían por correo a ciertos destinatarios con el paquete R [`{blastula}`](https://github.com/rstudio/blastula). Se ha automatizado que este flujo se repita todos los jueves al mediodía usando [Github Actions](https://github.com/features/actions).

Para su funcionamiento seguro, se ha necesitado implementar las siguientes *environmental variables*:

-   `APPSHEET_APP_ID`: ID de una aplicación de Google Appsheet. Se usa para obtener datos en `report.qmd`.
-   `APPSHEET_APP_ACCESS_KEY`: Llave de acceso de una aplicación de Google Appsheet. Se usa para obtener datos en `report.qmd`.
-   `GMAIL_USER_FROM`: Email de usuario que envia el correo.
-   `GMAIL_USER_NAME`: Nombre de usuario que envia el correo. Aunque está implementada, parece no tener efecto.
-   `GMAIL_USER_TO`: Email de usuarios que van a recibir el correo. Puede ser un solo email o varios separados por una coma y un espacio (`, `). Si son varios, deben especificarse dentro de una sola variable de texto (ejemplo: `"email1@ejemplo.com, email2@ejemplo.com, email3@ejemplo.com"`)
-   `BLASTULA_EMAIL_CREDS`: Texto generado al usar `blastula::create_smtp_creds_file()`. Normalmente usar dicha función genera un archivo de texto en el directorio de trabajo. Se tomó el contenido de ese archivo por seguridad. Ahora se crea manualmente el mismo archivo leyéndolo de esta environmental variable. dentro de `script.R`.
