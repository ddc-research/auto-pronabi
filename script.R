library(quarto)
library(blastula)

fecha <- lubridate::today("America/Lima")
output_file = glue::glue("pronabi-semanal-{fecha}.docx")

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

email <- compose_email(
	body = md("Test email"),
	footer = md(glue::glue("Enviado el {add_readable_time()}."))
)

# Sending email by SMTP using a credentials file
email |>
	add_attachment(file = output_file) |>
	smtp_send(
		from = Sys.getenv("GMAIL_USER_FROM"),
		to = Sys.getenv("GMAIL_USER_TO"),
		subject = "Testing the `smtp_send()` function 2",
		credentials = creds_file("email_creds")
	)

# Cleaning ----
cli::cli_alert_info("Cleaning")

file.remove("email_creds")
file.remove(output_file)
