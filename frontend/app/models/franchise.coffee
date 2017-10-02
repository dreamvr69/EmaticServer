`import DS from 'ember-data'`

Franchise = DS.Model.extend
  name:                DS.attr 'string'
  image:                DS.attr 'file'
  imageUrl:             DS.attr 'string'

`export default Franchise`
