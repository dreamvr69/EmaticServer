`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProjectScheduleRoute = Ember.Route.extend AuthenticatedRouteMixin,

  model: ->
#   TODO FIX
    @store.findAll('project')

  setupController: (controller, model) ->
    controller.set 'model',     model

`export default ProjectScheduleRoute`
