`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

SettingsRoute = Ember.Route.extend AuthenticatedRouteMixin, RouteMixin,

  queryParams:
    scope:
      refreshModel: true
    page:
      refreshModel: true
    perPage:
      refreshModel: true

  model: ->
    @get('session.currentUser')

  setupController: (controller, model) ->
    controller.set 'model',     model
    controller.set 'franchises', @store.findAll('franchise')
    controller.set 'clubs', @store.findAll('club')
    if model.get('isAdmin')
      controller.set 'selectedFranchise', model.get('franchise')
    if !(model.get('isAdminOrOwner'))
      controller.set 'selectedFranchise', model.get('franchise')
      clubs = []
      model.get('selectedClub').then (club) ->
        clubs.addObject club
        controller.set 'selectedClubs', clubs

`export default SettingsRoute`
