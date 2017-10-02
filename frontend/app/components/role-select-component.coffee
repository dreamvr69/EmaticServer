`import Ember from 'ember'`

RoleSelectComponentComponent = Ember.Component.extend

  store: Ember.inject.service()

  didRender: ->
    $('.radio').click (e)=>
      role = @get('store').peekRecord('role', $(e.target).attr('value'))
      roles = @get('availableRoles')
      roles.forEach (roles) =>
        @get('roles').removeObject role
      @get('roles').addObject role

`export default RoleSelectComponentComponent`
