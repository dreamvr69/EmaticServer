`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`

SharingSettingsController = Ember.Controller.extend ToastMixin,

  session: Ember.inject.service()

  vkShareScore:        null
  vkSharePerDay:        null

  twitterShareScore:   null
  twitterSharePerDay:   null

  facebookShareScore:  null
  facebookSharePerDay:  null

  instagramShareScore: null
  instagramSharePerDay: null

  selectedClubs: []

  acceptButtonDisabled: Ember.computed.equal 'selectedClubs.length', 0

  actions:
    acceptSettings: ->
      if confirm('Вы точно хотите применить настройки к выбранным клубам?')
        for club in @get('selectedClubs')
          club.set 'vkShareScore',         @get('vkShareScore')
          club.set 'vkSharePerDay',        @get('vkSharePerDay')

          club.set 'twitterShareScore',    @get('twitterShareScore')
          club.set 'twitterSharePerDay',   @get('twitterSharePerDay')

          club.set 'facebookShareScore',   @get('facebookShareScore')
          club.set 'facebookSharePerDay',  @get('facebookSharePerDay')

          club.set 'instagramShareScore',  @get('instagramShareScore')
          club.set 'instagramSharePerDay', @get('instagramSharePerDay')

          club.save()
          @showToast('Настройки шаринга успешно применены!')


`export default SharingSettingsController`
