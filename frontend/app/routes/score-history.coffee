`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ScoreHistoryRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: (params)->
    @store.findRecord('history/score', params.id)

  afterModel: ->
    $('.material-tooltip').remove()

`export default ScoreHistoryRoute`
