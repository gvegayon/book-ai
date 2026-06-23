library(rvest)
library(dplyr)
library(stringr)

html <- read_html("sunbelt2026-agenda.html")

# ── 1. REGISTRATION / PRICING ─────────────────────────────────────────────────

pricing_tab <- html |> html_element("#pricing")

# Each ticket category has a heading (.c-registration__ticket-category h3 a)
# followed by a table of ticket rows (tr[data-price])
categories <- pricing_tab |> html_elements(".ticket-category")

pricing_records <- lapply(categories, function(cat) {
  category_name <- cat |>
    html_element("h3.panel-title a") |>
    html_text() |>
    str_squish()

  rows <- cat |> html_elements("tr[data-price]")

  lapply(rows, function(row) {
    ticket_id   <- html_attr(row, "data-id")
    price       <- html_attr(row, "data-price") |> as.numeric()
    name_node   <- html_element(row, "td strong")
    ticket_name <- if (length(name_node) > 0) str_squish(html_text(name_node)) else NA_character_

    # Deadline or availability note from the lock icon's data-content
    lock <- html_element(row, "i.c-registration__lock")
    deadline_note <- if (length(lock) > 0) html_attr(lock, "data-content") else NA_character_

    tibble(
      category      = category_name,
      ticket_id     = ticket_id,
      ticket_name   = ticket_name,
      price_usd     = price,
      deadline_note = deadline_note
    )
  }) |> bind_rows()
}) |> bind_rows()

write.csv(pricing_records, "sunbelt2026_pricing.csv", row.names = FALSE)
cat(sprintf("Wrote %d pricing records to sunbelt2026_pricing.csv\n", nrow(pricing_records)))
print(pricing_records[, c("category", "ticket_name", "price_usd")])

cat("\n")

# ── 2. WORKSHOPS ──────────────────────────────────────────────────────────────

workshop_tab <- html |> html_element("#workshopinformation")
content      <- workshop_tab |> html_element("novi-content-wrapper")
nodes        <- content |> html_children()

current_section <- NA_character_
records <- list()

walk_nodes <- function(nodeset) {
  for (i in seq_along(nodeset)) {
    node <- nodeset[[i]]
    tag  <- html_name(node)

    if (tag == "h3") {
      current_section <<- str_trim(html_text(node))
    } else if (tag == "novi-accordion") {
      title_node <- html_element(node, "h4.panel-title a")
      if (!is.null(title_node) && length(title_node) > 0) {
        raw_title <- str_trim(html_text(title_node))

        body_node <- html_element(node, ".panel-body")
        description <- if (!is.null(body_node) && length(body_node) > 0) {
          str_squish(html_text(body_node))
        } else {
          NA_character_
        }

        parts <- str_split(raw_title, " - ", simplify = FALSE)[[1]]
        n <- length(parts)

        time_of_day <- NA_character_
        if (n >= 2 && str_detect(parts[n], "^(Morning|Afternoon)$")) {
          time_of_day <- parts[n]
          parts <- parts[-n]
          n <- n - 1
        }

        presenters <- if (n >= 2) parts[n] else NA_character_
        title      <- if (n >= 2) str_c(parts[-n], collapse = " - ") else parts[1]

        day_date     <- str_extract(current_section, "^\\w+\\s+[\\d/]+")
        session_type <- str_extract(current_section, "(?<=:\\s).+$")

        records[[length(records) + 1]] <<- tibble(
          section      = current_section,
          day          = str_extract(day_date, "^\\w+"),
          date         = str_extract(day_date, "[\\d/]+"),
          session_type = str_trim(session_type),
          time_of_day  = time_of_day,
          title        = str_trim(title),
          presenters   = str_trim(presenters),
          description  = description
        )
      }
    } else if (tag %in% c("div", "section")) {
      children <- html_children(node)
      if (length(children) > 0) walk_nodes(children)
    }
  }
}

walk_nodes(nodes)

workshops <- bind_rows(records) |>
  mutate(date_iso = as.Date(date, format = "%m/%d/%Y") |> format("%Y-%m-%d")) |>
  select(section, day, date, date_iso, session_type, time_of_day,
         title, presenters, description)

write.csv(workshops, "sunbelt2026_workshops.csv", row.names = FALSE)
cat(sprintf("Wrote %d workshop records to sunbelt2026_workshops.csv\n", nrow(workshops)))
print(workshops[, c("day", "date", "session_type", "time_of_day", "title", "presenters")])
