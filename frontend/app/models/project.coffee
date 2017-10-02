`import DS from 'ember-data'`

Project = DS.Model.extend


  event_name:           DS.attr 'string'
  client_name:          DS.attr 'string'
  company_name:         DS.attr 'string'
  client_phone:         DS.attr 'string'
  client_email:         DS.attr 'string'
  begin:                DS.attr 'string'
  end:                  DS.attr 'string'
  state:                DS.attr 'string'


  visualisations:         DS.hasMany   'visualisation'

`export default Project`
