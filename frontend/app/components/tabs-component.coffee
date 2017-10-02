`import Ember from 'ember'`

TabsComponentComponent = Ember.Component.extend

  didRender: ->
    $($('ul.tabs li.tab a.active').first().attr('href')).show()

    @$('ul.tabs li.tab a').click (e) =>
      $('ul.tabs li.tab a').removeClass('active')
      $(e.target).addClass('active')
      $('.tab-content').hide()
      $($(e.target).attr('href')).show()
      e.preventDefault()

`export default TabsComponentComponent`

