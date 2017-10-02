`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

NewClubRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    model = @store.createRecord('club')
    @get('session.currentUser').then (user) ->
      if !user.get('isOwner')
        model.set 'franchise', user.get('franchise')
      model.get('users').pushObject(user)
    model

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'franchises', @store.findAll('franchise')

`export default NewClubRoute`
