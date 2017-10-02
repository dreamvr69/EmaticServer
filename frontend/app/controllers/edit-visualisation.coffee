`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditVisualisationController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,


  fcHeader: Ember.computed ->
    left: "month, agendaWeek, agendaDay",
    center: "title",
    right: "today, prev, next"


  actions:
    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'projects'
        @scrollToTop()
        @showToast('Визуализация обновлёна')

`export default EditVisualisationController`
