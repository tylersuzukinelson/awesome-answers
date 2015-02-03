# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
#   a = 1
#   b = 5 if a > 10

#   sayHello = ->
#     alert "Hello"

#   sayHello()

#   alert(capitalize("tam"))
$ ->
  capitalize = (word) ->
    word.charAt(0).toUpperCase() + word.slice(1)

  # Exercise 1
  $('#e1').on 'click', ->
    $(@).toggleClass('btn-primary').toggleClass('btn-danger')
    false

  # Exercise 2
  $('#e2').click ->
    $(@).css('height', '+=10')
    $(@).css('width', '+=50')
    $(@).css('font-size', '+=5')
    false

  # Exercise 3
  $('#e3').on 'keyup', ->
    words = $(@).val().split(' ')
    output = words.map (word) -> capitalize(word)
    $('#e3out').text(output.join(' '))

  # Exercise 4
  bgcolors = []
  i = 0
  $('#e4').on 'keypress', (element) ->
    if element.which == 13
      bgcolors.push($('#e4').val())
      $('#e4out').append('<br />' + $('#e4').val())
      $('#e4').val('')
      if typeof e4interval != 'undefined'
        clearInterval(e4interval)
      e4interval = setInterval(colorChange, 500)
  colorChange = ->
    if i + 1 > bgcolors.length
      i = 0
    else
      i += 1
    $('body').css('background', bgcolors[i])

  true