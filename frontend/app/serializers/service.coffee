`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ServiceSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    clubs: {
      serialize: 'ids',
      deserialize: 'ids'
    }

`export default ServiceSerializer`
