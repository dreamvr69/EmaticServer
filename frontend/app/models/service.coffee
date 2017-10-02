`import DS from 'ember-data'`

Service = DS.Model.extend

  name:        DS.attr 'string'
  description: DS.attr 'string'
  price:       DS.attr 'string'
  type:        DS.attr 'string'

  clubs:       DS.hasMany 'club'
  franchise:   DS.belongsTo 'franchise'

`export default Service`
