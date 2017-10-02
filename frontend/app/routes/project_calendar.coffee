`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProjectCalendarRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
    @store.findAll('project')

  setupController: (controller, model) ->
    controller.set 'model',     model

`export default ProjectCalendarRoute`
