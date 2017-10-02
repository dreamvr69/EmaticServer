`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`

SettingsController = Ember.Controller.extend ToastMixin,

  session: Ember.inject.service()
  firstLevelMinScore: 100
  secondLevelMinScore: 200
  thirdLevelMinScore: 300
  fourthLevelMinScore: 400
  fifthLevelMinScore: 500
  maxScorePerDay: 1000
  selectedClubs: []

  acceptButtonDisabled: Ember.computed.equal 'selectedClubs.length', 0

  actions:
    acceptSettings: ->
      if confirm('Вы точно хотите применить настройки к выбранным клубам?')
        for club in @get('selectedClubs')
          club.set 'firstLevelMinScore',  @get('firstLevelMinScore')
          club.set 'secondLevelMinScore', @get('secondLevelMinScore')
          club.set 'thirdLevelMinScore',  @get('thirdLevelMinScore')
          club.set 'fourthLevelMinScore', @get('fourthLevelMinScore')
          club.set 'fifthLevelMinScore',  @get('fifthLevelMinScore')
          club.set 'maxScorePerDay',      @get('maxScorePerDay')
          club.save()
          @showToast('Настройки успешно применены!')



`export default SettingsController`
