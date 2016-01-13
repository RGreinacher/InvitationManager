(function() {
  var CheckboxHandler;

  CheckboxHandler = (function() {
    var _this, initAjax, performAjaxRequest, selectGuest, toggleAllGuests;

    _this = CheckboxHandler;

    CheckboxHandler.ajaxPath = '';

    function CheckboxHandler() {
      initAjax();
      $('.select-all-guests').on('click', function() {
        return toggleAllGuests($(this).prop('checked'));
      });
      $('.guest-checkbox').on('click', function() {
        return selectGuest($(this).val());
      });
    }

    initAjax = function() {
      this.ajaxPath = $('.new-guest-heading').data('ajax-path');
      return $.ajaxSetup({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      });
    };

    toggleAllGuests = function(status) {
      performAjaxRequest({
        enqueue_all_guests: status
      });
      return $('.guest-checkbox').prop('checked', status);
    };

    selectGuest = function(guest_id) {
      return performAjaxRequest({
        enqueue_guest: guest_id
      });
    };

    performAjaxRequest = function(data) {
      var ajaxPath;
      ajaxPath = this.ajaxPath;
      return $.ajax({
        type: 'PATCH',
        url: ajaxPath,
        dataType: 'json',
        data: data,
        success: function() {
          return console.log('successfully posted data via ajax');
        },
        error: function(a, b, c) {
          return console.log('faild to post data via ajax');
        }
      });
    };

    return CheckboxHandler;

  })();

  window.checkboxHandler = CheckboxHandler();

}).call(this);
