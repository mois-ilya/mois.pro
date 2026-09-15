-- Links that leave the site open in a new tab; links inside it do not.
--
-- The landing page is hand-written and carries the same attributes inline, so
-- this filter only covers the pages built from Markdown. mailto: is untouched
-- because it opens a mail client, not a page.

local function is_external(url)
  local host = url:match("^https?://([^/:?#]+)")
  if not host then return false end

  host = host:lower()
  return host ~= "mois.pro" and not host:match("%.mois%.pro$")
end

function Link(el)
  if is_external(el.target) then
    el.attributes["target"] = "_blank"
    -- Implied by modern browsers for target=_blank, stated anyway: it costs
    -- nothing and older ones hand the opened page a handle back to this one.
    el.attributes["rel"] = "noopener"
  end
  return el
end
