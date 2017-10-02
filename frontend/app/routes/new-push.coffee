`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

NewPushRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    model = @store.createRecord('push')
    @get('session.currentUser').then (user) ->
      model.set 'creator', user
    model

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'franchises', @get('store').findAll('franchise')
    controller.set 'pushChannels', @get('store').findAll('push-channel')
    controller.set 'users', @get('store').findAll('user')

`export default NewPushRoute`
