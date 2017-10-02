`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditClubController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  store: Ember.inject.service()
  addBaseServiceSelected: false
  selectedBaseService: null

  baseServices:  Ember.computed.filterBy 'model.services', 'type', 'base'
  extraServices: Ember.computed.filterBy 'model.services', 'type', 'extra'

  timepickerOptions: Ember.computed ->
    {format: "HH:i"}


  selectedBaseServiceObserver: Ember.observer 'selectedBaseService', ->
    if !Ember.isEmpty(@get('selectedBaseService'))
      @get('model.services').pushObject @get('selectedBaseService')
      @set 'selectedBaseService', null

  actions:
    save: ->
      arrayOfPromises = []
      arrayOfPromises.push @get('shedule').then (shedule) =>
        shedule.save()
      arrayOfPromises.push @get('model').save().then (model) =>
        @get('model.services').forEach (service, i) ->
          arrayOfPromises.push service.save()

      Ember.RSVP.Promise.all(arrayOfPromises).then =>
        @transitionToRoute 'club', @get('model.id')
        @scrollToTop()
        @showToast('Клуб успешно сохранен!')

    deleteImage: (image) ->
      if confirm('Удалить изображение?')
        image.destroyRecord()
        @showToast('Изображение успешно удалено!')

    setTime: ->
      @set ('model.clubShedule.weekdaysTimeStart'), $('#weekdaysTimeStart').val()
      @set ('model.clubShedule.weekdaysTimeStop'),  $('#weekdaysTimeStop').val()
      @set ('model.clubShedule.weekendTimeStart'),  $('#weekendTimeStart').val()
      @set ('model.clubShedule.weekendTimeStop'),   $('#weekendTimeStop').val()

    addBaseService: ->
      @set 'addBaseServiceSelected', true
      false

    addExtraService: ->
      service = @get('store').createRecord 'service'
      service.set 'type', 'extra'
      service.get('clubs').pushObject @get('model')
      service.save()
      @get('model.services').pushObject service

    removeExtraService: (service) ->
      if confirm('Удалить услугу?')
        service.destroyRecord()
        @showToast('Услуга успешно удалена!')

    removeBaseService: (service) ->
      if confirm('Удалить услугу?')
        @get('model.services').removeObject service
        @showToast('Услуга успешно удалена!')


`export default EditClubController`
