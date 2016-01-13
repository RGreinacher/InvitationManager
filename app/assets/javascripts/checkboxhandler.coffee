class CheckboxHandler

  _this = this
  this.ajaxPath = ''

  constructor: ->
    initAjax()
    this.ajaxPath = $('.new-guest-heading').data('ajax-path')

    $('.select-all-guests').on 'click', ->
      status = $(this).prop('checked')
      filter = $('#list-of-guests').data('current-filter')
      toggleAllCompanies(status, filter)

    $('.guest-checkbox').on 'click', ->
      selectCompany($(this).val())

  initAjax = () ->
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  toggleAllCompanies = (status, filter) ->
    performAjaxRequest({
      enqueue_all_guests: status,
      current_filter: filter
    })

    if status
      $('.guest-row:not(.hidden) .guest-checkbox').prop('checked', true)
    else
      $('.guest-checkbox').prop('checked', false)

  selectCompany = (guest_id) ->
    performAjaxRequest({ enqueue_guest: guest_id })

  performAjaxRequest = (data) ->
    $.ajax
      type: 'PATCH',
      url: this.ajaxPath,
      dataType: 'json'
      data: data,
      success: ->
        console.log('successfully posted data via ajax')
      error: ->
        console.log('faild to post data via ajax')


window.checkboxHandler = CheckboxHandler()
