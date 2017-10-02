`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: (params)->
    @store.findRecord('push-channel', params.id)

  afterModel: ->
    $('.material-tooltip').remove()

`export default PushChannelRoute`
