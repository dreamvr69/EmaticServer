`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

CustomScoreController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,

  session: Ember.inject.service()
  store:   Ember.inject.service()
  sex:          null
  franchise:    null
  club:         null
  formattedSex: null
  ageFrom:      null
  ageTo:        null
  selectedUsers:  []
  comment:      null

  SEXES: ['Мужской', 'Женский']

  SEXES_DICTIONARY:  {
    'Мужской': 'male'
    'Женский': 'female'
  }

  pushText: Ember.computed 'score', ->
    "На ваш бонусный счёт начислено " + @get('score') + " баллов. Спасибо, что вы с нами!"

  sexObserver: Ember.observer 'sex', ->
    if Ember.isEmpty('sex')
      @set 'formattedSex', null
    else
      @set 'formattedSex', @get('SEXES_DICTIONARY')[@get('sex')]

  filteredUsers: Ember.computed 'club', 'franchise', 'formattedSex',
    'ageFrom', 'ageTo', 'filterName', 'model.users.@each', 'users', 'users.@each',->
      users =  @get('users')
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
      if Ember.isPresent(@get('franchise'))
        users.filterBy 'franchise', @get('franchise')
      if Ember.isPresent(@get('club'))
        users = users.filter (user) =>
          user.get('clubs').includes @get('club')

      return users

  actions:
    removeFranchise: ->
      @set 'franchise', null
      @set 'club', null

    removeClub: ->
      @set 'club', null

    removeSex: ->
      @set 'sex', null

    save: ->
      arrayOfPromises = []
      @get('session.currentUser').then (currentUser) =>
        for user in @get('selectedUsers')
          user.get('loyalty').then (loyalty) =>
            loyalty.set 'score', loyalty.get('score') + parseInt(@get('score'))
            arrayOfPromises.push loyalty.save()
            history = @get('store').createRecord('history/score', client: user, manager: currentUser, score: @get('score'), comment: @get('comment'))
            arrayOfPromises.push history.save()
            push = @get('store').createRecord('push', title: 'Начисление баллов', text: @get('pushText'), creator: currentUser)
            push.get('users').pushObject user
            arrayOfPromises.push push.save()

        Ember.RSVP.Promise.all(arrayOfPromises).then =>
          @showToast('Баллы успешно начислены!')

`export default CustomScoreController`
