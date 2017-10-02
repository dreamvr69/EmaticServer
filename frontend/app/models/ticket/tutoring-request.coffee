`import DS from 'ember-data'`
`import TicketBaseModelMixin from '../../mixins/ticket-base-model'`

TicketTutoringRequest = DS.Model.extend TicketBaseModelMixin,

  repeatsCount:     DS.attr 'number'

  user:             DS.belongsTo 'user'
  coach:            DS.belongsTo 'coach'

`export default TicketTutoringRequest`
