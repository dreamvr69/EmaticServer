`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

NewQrRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    model = @store.createRecord('qr')
    @get('session.currentUser').then (user) ->
      model.set 'club', user.get('selectedClub')
    model

`export default NewQrRoute`
