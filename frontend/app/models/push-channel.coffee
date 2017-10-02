`import DS from 'ember-data'`

PushChannel = DS.Model.extend

  name:        DS.attr 'string'
  description: DS.attr 'string'

  club:      DS.belongsTo 'club'
  franchise: DS.belongsTo 'franchise'
  users:     DS.hasMany 'user'

`export default PushChannel`
