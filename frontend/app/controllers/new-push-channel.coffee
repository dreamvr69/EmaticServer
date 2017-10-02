`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

NewPushChannelController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()
  sex: null
  formattedSex: null
  ageFrom: null
  ageTo: null

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

  filteredUsers: Ember.computed 'model.club', 'model.franchise', 'formattedSex',
    'ageFrom', 'ageTo', 'filterName', ->
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
    removeFranchise: ->
      @set 'model.franchise', null
      @set 'model.club', null

    removeClub: ->
      @set 'model.club', null

    removeSex: ->
      @set 'sex', null

    save: ->
      @get('model').save().then (model)=>
        @transitionToRoute 'push-channel', model.id
        @scrollToTop()
        @showToast('Группа клиентов успешно добавлена!')

`export default NewPushChannelController`
