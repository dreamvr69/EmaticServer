`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewQrController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()

  actions:
    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'qr', model.id
        @scrollToTop()
        @showToast('Полезное действие успешно добавлено!')

`export default NewQrController`
