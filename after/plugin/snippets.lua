local ls = require 'luasnip'

-- Example of HTMX snippets
ls.snippets = {
	html = {
		ls.parser.parse_snippet("hxget", 'hx-get="$1" hx-target="$2" hx-swap="$3"'), -- HTMX GET
		ls.parser.parse_snippet("hxpost", 'hx-post="$1" hx-target="$2" hx-swap="$3"'), -- HTMX POST
	}
}
