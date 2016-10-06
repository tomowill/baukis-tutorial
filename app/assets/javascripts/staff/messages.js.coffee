$(document).on 'page:change', ->
  if $('#number-of-unprocessed-messages').length
    setInterval(update_number_of_unprocessed_messages, 1000 * 30)

    update_number_of_unprocessed_messages = ->
      $.get window.paths.number_of_unprocessed_messages, (data) ->
        $('#number-of-unprocessed-messages').text "(#{data})"
