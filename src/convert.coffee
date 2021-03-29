# capitalize = (string) ->
#   string[0].toUpperCase() + string[1..]
#
# titleCase = (string) ->
#   string
#   .toLowerCase()
#   .replace(/^(\w)|\W(\w)/g, (char) -> char.toUpperCase())
#
# camelCase = (string) ->
#   string.toLowerCase().replace(/(\W+\w)/g, (string) ->
#     string.trim().toUpperCase())
#
# underscored = (string) -> plainText(string).replace(/\W+/g, "_")
#
# dashed = (string) -> plainText(string).replace(/\W+/g, "-")
#
# htmlEscape = do ->
#
#   map =
#     "&": "&amp;"
#     "<": "&lt;"
#     ">": "&gt;"
#     '"': '&quot;'
#     "'": '&#39;'
#     "/": '&#x2F;'
#
#   entities = Object.keys( map )
#   re = new RegExp( "#{entities.join('|')}", "g" )
#   (string) -> string.replace( re, (s) -> map[s] )
