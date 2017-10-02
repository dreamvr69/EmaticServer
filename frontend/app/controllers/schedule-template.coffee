`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

ScheduleTemplateController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  store: Ember.inject.service()
  scheduleWorkout: null

  fcHeader: Ember.computed ->
    left: "agendaWeek"
    right: ""

  events: Ember.computed 'model.scheduleWorkouts.length', 'model.scheduleWorkouts.@each.name',
    'model.scheduleWorkouts.@each.start', 'model.scheduleWorkouts.@each.end', 'model.scheduleWorkouts.isFulfilled',->
      if @get('model.scheduleWorkouts')?
        @get('model.scheduleWorkouts').map (event) =>
          {
            id: event.get('id')
            title: event.get('name')
            start: event.get('start')
            end: event.get('end')
          }

  actions:

    save: ->
      @get('model').save().then (model) =>
        @transitionToRoute 'schedule-templates'
        @scrollToTop()
        @showToast('Шаблон расписания успешно сохранен!')

    openEvent: (event)->
      @set 'scheduleWorkout', @get('store').findRecord('schedule-workout', event.id)
      $('#workout-modal').openModal()

    closeModal: ->
      $('#workout-modal').closeModal()

    deleteWorkout: ->
      if confirm('Удалить занятие?')
        @get('scheduleWorkout.content').destroyRecord()
        $('#workout-modal').closeModal()
        @showToast('Тренировка успешно удалена!')

    saveWorkout: ->
      @get('scheduleWorkout.content').save()
      $('#workout-modal').closeModal()
      @showToast('Тренировка успешно изменена!')

    setTemplate: (template) ->
      @set 'scheduleWorkout.name', template.get('name')
      @set 'scheduleWorkout.description', template.get('description')
      @set 'scheduleWorkout.duration', template.get('duration')
      @set 'scheduleWorkout.seatsCount', template.get('seatsCount')
      @set 'scheduleWorkout.gym', template.get('gym')
      @set 'scheduleWorkout.shareUrl', template.get('shareUrl')
      @set 'scheduleWorkout.isNeedManagerConfirm', template.get('isNeedManagerConfirm')
      return false

    openNewWorkoutModal: ->
      @set 'scheduleWorkout', @get('store').createRecord('schedule-workout')
      @set 'scheduleWorkout.club', @get('selectedClub')
      $('#new-workout-modal').openModal()

    addWorkout: ->
      @set 'scheduleWorkout.scheduleTemplate', @get('model')
      @get('scheduleWorkout').save().then
      $('#new-workout-modal').closeModal()
      @showToast('Тренировка успешно добавлена!')
      @transitionToRoute 'schedule-template', @get('model.id')


`export default ScheduleTemplateController`
