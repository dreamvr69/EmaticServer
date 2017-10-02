`import DS from 'ember-data'`

Push = DS.Model.extend

  STATES: {
    'waiting':   'Ожидает отправки'
    'pushed':    'Отправлен'
    'canceled':  'Отправка отменена'
  }

  title:        DS.attr 'string'
  text:         DS.attr 'string'
  aasmState:    DS.attr 'string'
  deliveryDate: DS.attr 'string'

  creator:      DS.belongsTo 'user', { inverse: 'createdPushes' }
  users:        DS.hasMany   'user'

  formattedPublicationDate: Ember.computed 'deliveryDate', ->
    moment(@get('deliveryDate')).format('DD.MM.YYYY H:m')

  formattedAasmState: Ember.computed 'aasmState', ->
    @get('STATES')[@get('aasmState')]

  formattedCreator: Ember.computed 'creator', 'creator.isFulfilled', 'creator.userType',
    'creator.userType.isFulfilled',->
      @get('creator.name') + ', ' + @get('creator.userType.name')

`export default Push`
