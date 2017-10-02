`import DS from 'ember-data'`

Qr = DS.Model.extend

  name:                      DS.attr 'string'
  description:               DS.attr 'string'
  score:                     DS.attr 'number'

  usageFrequencyForClient:   DS.attr 'number'
  usageFrequency:            DS.attr 'number'

  usageLimitPerDayForClient: DS.attr 'number'
  usageLimitPerDay:          DS.attr 'number'

  usageLimitForClient:       DS.attr 'number'
  usageLimit:                DS.attr 'number'

  codeUrl:                   DS.attr 'string'

  club:                      DS.belongsTo 'club'

`export default Qr`
