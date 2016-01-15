(function() {
  var SendEditFormHandler;

  SendEditFormHandler = (function() {
    var _this, initAjax, performAjaxRequest, submitEditForm;

    _this = '';

    function SendEditFormHandler() {
      initAjax();
      _this = this;
      this.editForm = $('.guest-edit-form');
      this.ajaxRequestAttempts = 0;
      this.timeoutCount = 0;
      this.ajaxRequestDelay = 5000;
      $("input[type='radio']").change(function() {
        return submitEditForm();
      });
      $('#guest_companions, #guest_notice').focusout(function() {
        return submitEditForm();
      });
    }

    initAjax = function() {
      return $.ajaxSetup({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      });
    };

    submitEditForm = function() {
      this.ajaxRequestAttempts += 1;
      return setTimeout(function() {
        _this.timeoutCount += 1;
        if (_this.ajaxRequestAttempts === _this.timeoutCount) {
          return performAjaxRequest();
        }
      }, this.ajaxRequestDelay);
    };

    performAjaxRequest = function() {
      var data, type, url;
      url = this.editForm.attr('action');
      type = this.editForm.attr('method');
      data = this.editForm.serialize();
      return $.ajax({
        url: url,
        type: type,
        dataType: 'json',
        data: data,
        success: function() {
          return console.log('successfully posted guest answer via ajax');
        },
        error: function(a, b, c) {
          return console.log('faild to post guest answer via ajax');
        }
      });
    };

    return SendEditFormHandler;

  })();

  window.sendEditFormHandler = SendEditFormHandler();

}).call(this);
