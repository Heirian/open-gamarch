jQuery ->
  $(document).on 'turbolinks:load', ->
    if $('#with-button').size() > 0
        $('#with-button .pagination').hide()
        loading_comments = false

        $('#load_more_comments').show().click ->
          unless loading_comments
            loading_comments = true
            image = image_path('ajax-loader.gif')
            icon = '<img src="#{image}" alt="Loading" title="Loading" />'
            more_comments_url = $('#with-button .next_page a').attr('href')
            if more_comments_url
              $this = $(this)
              $this.html(icon).addClass('disabled')
              $.getScript more_comments_url, ->
                $this.text('Load comments').removeClass('disabled') if $this
                loading_comments = false

    return
