`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EditClientRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: (params)->
    @store.findRecord('user', params.id)

  afterModel: ->
    $('.material-tooltip').remove()

`export default EditClientRoute`
