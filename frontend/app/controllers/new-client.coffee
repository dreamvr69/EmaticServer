`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewClientController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()

  actions:
    save: ->
      @get('model').save().then (model) =>
        @transitionToRoute ''
        @scrollToTop()
        @showToast('Пользователь успешно создан!')

    clubOnSelect: (role) ->
      @set 'model.role', role

`export default NewClientController`
