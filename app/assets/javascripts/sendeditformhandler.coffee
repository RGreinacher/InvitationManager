class SendEditFormHandler

  _this = ''

  constructor: ->
    initAjax()
    _this = this
    this.editForm = $('.guest-edit-form')
    this.ajaxRequestAttempts = 0
    this.timeoutCount = 0
    this.ajaxRequestDelay = 5000

    $("input[type='radio']").change ->
      submitEditForm()

    $('#guest_companions, #guest_notice').focusout ->
      submitEditForm()

  initAjax = () ->
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  submitEditForm = () ->
    this.ajaxRequestAttempts += 1
    setTimeout ->
      _this.timeoutCount += 1
      if _this.ajaxRequestAttempts == _this.timeoutCount
        performAjaxRequest()
    , this.ajaxRequestDelay

  performAjaxRequest = () ->
    url = this.editForm.attr('action')
    type = this.editForm.attr('method')
    data = this.editForm.serialize()

    $.ajax({
      url: url,
      type: type,
      dataType: 'json',
      data: data,
      success: ->
        console.log('successfully posted guest answer via ajax')
      error: (a, b, c) ->
        console.log('faild to post guest answer via ajax')
    });

window.sendEditFormHandler = SendEditFormHandler()
