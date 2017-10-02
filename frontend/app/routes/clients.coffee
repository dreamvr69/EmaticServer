`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ClientsRoute = Ember.Route.extend AuthenticatedRouteMixin, RouteMixin,

  queryParams:
    scope:
      refreshModel: true
    page:
      refreshModel: true
    perPage:
      refreshModel: true

  beforeModel: ->
    @store.peekAll('user').forEach (user) =>
      if user.id != @get('session.session.content.authenticated.user_id')
        user.unloadRecord()

  model: (params) ->
    @findPaged('user', params)

`export default ClientsRoute`
