`import DS from 'ember-data'`

Note = DS.Model.extend


  body:           DS.attr 'string'
  creation_date:  DS.attr 'string'
  author_name:  DS.attr 'string'

`export default Note`
