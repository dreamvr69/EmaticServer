`import Ember from 'ember'`

JqueryDatetimepickerComponent = Ember.Component.extend

  didRender: ->
    @$('.datetimepicker').datetimepicker
      dateFormat:'Y-m-d'
      timeFormat:'HH:MM'
      lang:'ru'

`export default JqueryDatetimepickerComponent`
