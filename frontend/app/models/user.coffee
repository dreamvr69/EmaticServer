`import DS from 'ember-data'`

User = DS.Model.extend
  email:                 DS.attr 'string'
  name:                  DS.attr 'string'
  mobile:                DS.attr 'string'

  password:              DS.attr 'string'

  is_franchise_administrator: DS.attr 'boolean'
  is_franchise_administrator_or_super_user: DS.attr 'boolean'

  rolesList:     DS.attr()

  userRoles:    DS.attr()
  userRole:     DS.attr 'string'
  franchise:    DS.belongsTo 'franchise'
  franchise_id: DS.attr 'string'

  formattedAuthDate: Ember.computed 'authDate', ->
    if @get('authDate')?
      moment(@get('authDate')).format('DD.MM.YYYY H:m')
    else
      'Еще не авторизован'

  panelAccountsScope: Ember.computed 'isOwner', 'isAdmin', 'isAdminOrOwner', ->
    if @get('isOwner')
      ''
    else if @get('isAdmin')
      'franchise_users'
    else
      'club_users'

`export default User`
