`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditFranchiseController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,

  store: Ember.inject.service()

  actions:
    save: ->
      arrayOfPromises = []
      arrayOfPromises.push @get('model').save().then (model)=>
        @get('model.services').forEach (service, i) ->
          arrayOfPromises.push service.save()

      Ember.RSVP.Promise.all(arrayOfPromises).then =>
        @transitionToRoute 'franchise', @get('model.id')
        @scrollToTop()
        @showToast('Франшиза успешно сохранена!')

    addService: ->
      service = @get('store').createRecord 'service'
      service.set 'franchise', @get('model')
      service.save()
      @get('model.services').pushObject service

    removeService: (service) ->
      if confirm('Удалить услугу?')
        service.destroyRecord()
        @showToast('Услуга успешно удалена!')

`export default EditFranchiseController`
