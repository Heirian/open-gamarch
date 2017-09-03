jQuery ->
  $(document).on 'turbolinks:load', ->
    if $('#with-button').size() > 0
        $('#with-button .pagination').hide()
        loading_comments = false

        $('#load_more_comments').show().click ->
          unless loading_comments
            loading_comments = true
            more_comments_url = $('#with-button .next_page a').attr('href')
            if more_comments_url
              $this = $(this)
              $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled')
              $.getScript more_comments_url, ->
                $this.text('Load comments').removeClass('disabled') if $this
                loading_comments = false
          return

    return
