`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

EditClientController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,

  actions:
    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'client', model.id
        @scrollToTop()
        @showToast('Данные клиента успешно сохранены!')

`export default EditClientController`
