`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

PushChannelSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    users: {
      serialize: 'ids',
      deserialize: 'ids'
    }

`export default PushChannelSerializer`
