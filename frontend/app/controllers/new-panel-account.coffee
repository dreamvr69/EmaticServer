`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewPanelAccountController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()

  accountTypeObserver: Ember.observer 'model.userType', ->
    @set 'model.franchise',   null
    @set 'model.clubs',       []
    @set 'model.selectedClub', null

  actions:
    save: ->
      @get('model').save().then =>
        @transitionToRoute 'panel-accounts'
        @scrollToTop()
        @showToast('Аккаунт успешно создан!')

`export default NewPanelAccountController`
