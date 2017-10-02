`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditProjectController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,


  fcHeader: Ember.computed ->
    left: "month, agendaWeek, agendaDay",
    center: "title",
    right: "today, prev, next"

  events: Ember.computed 'model.visualisations.@each.id', 'model.visualisations.@each.room',
    'model.visualisations.@each.begin', 'model.visualisations.@each.end', ->
      @get('model.visualisations').map (event) =>
        {
          id: event.get('id')
          title: event.get('room')
          start: event.get('begin')
          end: event.get('end')
        }

  actions:
    setType: (type) ->
      @set 'model.type', type

    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'projects'
        @scrollToTop()
        @showToast('Статус проекта обновлён')

    editVisualisation: (visualisation) ->
      @transitionToRoute 'edit-visualisation', visualisation.id



`export default EditProjectController`
