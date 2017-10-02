`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewPushController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,

  session: Ember.inject.service()
  sex:          null
  franchise:    null
  club:         null
  formattedSex: null
  ageFrom:      null
  ageTo:        null
  pushChannel:  null

  saveButtonDisabled: Ember.computed.empty 'model.users'

  SEXES: ['Мужской', 'Женский']

  SEXES_DICTIONARY:  {
    'Мужской': 'male'
    'Женский': 'female'
  }

  sexObserver: Ember.observer 'sex', ->
    if Ember.isEmpty('sex')
      @set 'formattedSex', null
    else
      @set 'formattedSex', @get('SEXES_DICTIONARY')[@get('sex')]

  pushChannelOnSelect: Ember.observer 'pushChannel', ->
    @set 'model.users', []
    if !Ember.isEmpty(@get('pushChannel'))
      @get('pushChannel.users').then (users) =>
        for user in users.canonicalState
          @get('model.users').pushObject user.record

  filteredUsers: Ember.computed 'model.club', 'model.franchise', 'formattedSex',
    'ageFrom', 'ageTo', 'filterName', 'model.users@each', ->

      if @get('pushChannel')
        users = @get('model.users')
      else
        if @get('model.club.content')
          users = @get('model.club.users')
        else
          if @get('model.franchise.content')
            users = @get('model.franchise.users')
          else
            users = @get('users')
      if Ember.isPresent(@get('formattedSex'))
        users = users.filterBy 'sex', @get('formattedSex')
      if Ember.isPresent(@get('ageFrom'))
        users = users.filter (user) =>
          user.get('age') >= @get('ageFrom')
      if Ember.isPresent(@get('ageTo'))
        users = users.filter (user) =>
          user.get('age') <= @get('ageTo')
      if Ember.isPresent(@get('filterName'))
        users = users.filter (user) =>
          user.get('name').includes @get('filterName')
      return users

  actions:
    removePushChannel: ->
      @set 'pushChannel', null

    removeFranchise: ->
      @set 'franchise', null
      @set 'club', null

    removeClub: ->
      @set 'club', null

    removeSex: ->
      @set 'sex', null

    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'pushes'
        @scrollToTop()
        @showToast('Пуш отправлен')

`export default NewPushController`
