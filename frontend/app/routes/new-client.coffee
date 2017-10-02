`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

NewClientRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    model = @store.createRecord('user')
    @get('session.currentUser').then (user) ->
      if user.get('isAdmin')
        model.set 'franchise', user.get('franchise')
      if user.get('isManager')
        model.set 'club', user.get('selectedClubs')
    model

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'franchises', @store.findAll('franchise')

`export default NewClientRoute`
