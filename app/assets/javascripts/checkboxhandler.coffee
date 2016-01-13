class CheckboxHandler

  _this = this
  this.ajaxPath = ''

  constructor: ->
    initAjax()

    $('.select-all-guests').on 'click', ->
      toggleAllGuests($(this).prop('checked'))

    $('.guest-checkbox').on 'click', ->
      selectGuest($(this).val())

  initAjax = () ->
    this.ajaxPath = $('.new-guest-heading').data('ajax-path')
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  toggleAllGuests = (status) ->
    performAjaxRequest({ enqueue_all_guests: status })
    $('.guest-checkbox').prop('checked', status)

  selectGuest = (guest_id) ->
    performAjaxRequest({ enqueue_guest: guest_id })

  performAjaxRequest = (data) ->
    ajaxPath = this.ajaxPath
    $.ajax
      type: 'PATCH',
      url: ajaxPath,
      dataType: 'json'
      data: data,
      success: ->
        console.log('successfully posted data via ajax')
      error: (a, b, c) ->
        console.log('faild to post data via ajax')

window.checkboxHandler = CheckboxHandler()
