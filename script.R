library(quarto)
library(blastula)

fecha_fin <- lubridate::today("America/Lima")
fecha_inicio <- fecha_fin - lubridate::days(7)
output_file = glue::glue("pronabi-semanal-{fecha_fin}.docx")

# Rendering report ---
cli::cli_alert_info("Rendering report")

quarto_render(input = "report.qmd", output_file = output_file, quiet = TRUE)

# Creating email creds ----
cli::cli_alert_info("Creating email creds")

file.create("email_creds")
creds_file <- file("email_creds")
writeLines(text = Sys.getenv("BLASTULA_EMAIL_CREDS"), con = creds_file)
close(creds_file)

# Sending email ----
cli::cli_alert_info("Sending email")

formatted_time <- lubridate::now(tzone = "America/Lima") |> 
	format("%A %d de %B del %Y a las %H:%M (hora de Lima).")

email <- compose_email(
	body = md(glue::glue(
		"# SISETRA - Reporte semanal
		
		Se ha generado un reporte de producción del equipo de transferencias a 
		PRONABI de la Dirección de Control de Drogas y Cultivos Ilegales. 
		Descargue los archivos adjuntos para ver el contenido.
		
		- **Fecha de inicio:** {format(fecha_inicio, \"%A %d de %B del %Y\")}
		- **Fecha de fin:** {format(fecha_fin, \"%A %d de %B del %Y\")}
		
		Este reporte se genera automáticamente, no es necesario responder.
		"
	)),
	footer = md(glue::glue("Enviado el {formatted_time}."))
) |> 
	add_attachment(file = output_file)

# email

# Sending email by SMTP using a credentials file

send_email <- function() {
	email |>
		smtp_send(
			from = Sys.getenv("GMAIL_USER_FROM") |> setNames(Sys.getenv("GMAIL_USER_NAME")),
			to = Sys.getenv("GMAIL_USER_TO") |> stringr::str_split_1(pattern = ", "),
			subject = "Reporte semanal - Transferencias a PRONABI",
			credentials = creds_file("email_creds")
		)
}

clean_up <- function() {
	cli::cli_alert_info("Cleaning")
	
	file.remove("email_creds")
	file.remove(output_file)
}

tryCatch(
	{
		send_email()
		cli::cli_alert_success("Email sent")
		clean_up()
	}, 
	error = function(e) {
		clean_up()
		cli::cli_abort("{e}")
	}
)

