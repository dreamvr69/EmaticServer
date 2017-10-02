`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

NewPushChannelRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    model = @store.createRecord('push-channel')
    @get('session.currentUser').then (user) ->
      unless user.get('isOwner')
        user.get('franchise').then (franchise) ->
          model.set 'franchise', franchise
      unless user.get('isAdminOrOwner')
        user.get('selectedClub').then (club) ->
          model.set 'club', club
    model

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'franchises', @get('store').findAll('franchise')
    controller.set 'users', @get('store').findAll('user')

`export default NewPushChannelRoute`
