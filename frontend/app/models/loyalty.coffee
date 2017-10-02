`import DS from 'ember-data'`

Loyalty = DS.Model.extend

  score: DS.attr 'number'
  user:  DS.belongsTo 'user'

`export default Loyalty`
