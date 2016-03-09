# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@nameSorter = (l, r) ->
  if $(l).text() < $(r).text()
    return -1
  if $(l).text() > $(r).text()
    return 1
  return 0
