`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ClubSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    services: {
      serialize: 'ids',
      deserialize: 'ids'
    }

`export default ClubSerializer`
