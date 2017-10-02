`import DS from 'ember-data'`

Visualisation = DS.Model.extend


  room:           DS.attr 'string'
  begin:          DS.attr 'string'
  end:            DS.attr 'string'
  image_url:      DS.attr 'string'
  image:                DS.attr 'file'

  project: DS.belongsTo 'project'
  notes:         DS.hasMany   'note'

`export default Visualisation`
