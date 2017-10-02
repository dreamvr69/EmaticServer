`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

CustomScoreRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    @get('session.currentUser')

  setupController: (controller, model) ->
    controller.set 'franchises',   @get('store').findAll('franchise')
    controller.set 'users', @get('store').query('user', { scope: 'clients' })
    if model.get('isAdmin')
      controller.set 'franchise', model.get('franchise')
    if model.get('isManager')
      controller.set 'club', model.get('selectedClub')

`export default CustomScoreRoute`
