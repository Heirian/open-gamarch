jQuery ->
  $(document).on 'turbolinks:load', ->
    if $('#infinite-scrolling').size() > 0
      $(window).bindWithDelay 'scroll', ->
        more_posts_url = $('#infinite-scrolling .next_page a').attr('href')
        if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 300
          $('#infinite-scrolling .pagination').html(
            '<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
          $.getScript more_posts_url, ->
        return
      , 10

    return
