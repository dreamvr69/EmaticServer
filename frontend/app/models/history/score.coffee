`import DS from 'ember-data'`

HistoryScore = DS.Model.extend

  TYPES:  {
    'qr':  'Полезное действие'
    'sharing': 'Шаринг в сети'
    'custom':  'Начислено в ручную'
  }

  score:          DS.attr 'number'
  comment:        DS.attr 'string'
  createdAt:      DS.attr 'string'
  type:           DS.attr 'string'

  client:         DS.belongsTo 'user'
  manager:        DS.belongsTo 'user', { inverse: 'createdScoreHistories' }

  formattedDateTime: Ember.computed 'createdAt', ->
    moment(@get('createdAt')).format('DD.MM.YYYY H:m')

  formattedType: Ember.computed 'type', ->
    @get('TYPES')[@get('type')]

  formattedManager: Ember.computed 'manager', 'manager.isFulfilled', 'manager.franchise.isFulfilled', 'manager.selectedClub.isFulfilled',->
    'Баллы начислил: ' + @get('manager.name') + ', Франшиза: ' + @get('manager.franchise.name') + ', Клуб: ' + @get('manager.selectedClub.name')

`export default HistoryScore`
