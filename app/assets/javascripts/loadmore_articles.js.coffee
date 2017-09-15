jQuery ->
  $(document).on 'turbolinks:load', ->
    if $('#with-button-article').size() > 0
        $('#with-button-article .pagination').hide()
        loading_articles = false

        $('#load_more_articles').show().click ->
          unless loading_articles
            loading_articles = true
            image = image_path('ajax-loader.gif')
            icon = '<img src="#{image}" alt="Loading" title="Loading" />'
            more_articles_url = $('#with-button-article .next_page a').attr('href')
            if more_articles_url
              $this = $(this)
              $this.html(icon).addClass('disabled')
              $.getScript more_articles_url, ->
                $this.text('Load articles').removeClass('disabled')
                loading_articles = false
          return

    return
