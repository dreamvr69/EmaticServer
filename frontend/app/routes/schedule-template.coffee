`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ScheduleTemplateRoute = Ember.Route.extend AuthenticatedRouteMixin,

  beforeModel: ->
    @store.unloadAll('schedule-workout')

  model: (params)->
    @store.findRecord('schedule-template', params.id)

  afterModel: ->
    $('.material-tooltip').remove()

  setupController: (controller, model) ->
    controller.set 'model',     model
    controller.set 'types',     @store.findAll('workout/type')
    controller.set 'templates', @store.findAll('workout/template')
    controller.set 'coaches',   @store.findAll('coach')
    @get('session.currentUser').then (user) ->
      controller.set 'selectedClub', user.get('selectedClub')

  actions:
    didTransition: ->
      Ember.run.schedule 'afterRender', this, ->
        $('.fc-agendaWeek-button').click().hide()

`export default ScheduleTemplateRoute`
