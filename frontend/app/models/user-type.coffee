`import DS from 'ember-data'`

UserType = DS.Model.extend

  name:        DS.attr 'string'
  description: DS.attr 'string'

  isOwner:              DS.attr 'boolean'
  isFranchiseAdmin:     DS.attr 'boolean'
  isClubAdmin:          DS.attr 'boolean'

  club:      DS.belongsTo 'club'
  roles:     DS.hasMany   'roles'

  availableActions: Ember.computed 'roles.isFulfilled', ->
    actions = []
    @get('roles').forEach (role) ->
      actions.push role.get('name')
    actions.join(', ')

`export default UserType`
