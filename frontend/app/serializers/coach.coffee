`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

CoachSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    trainingPackages: {
      serialize: 'ids',
      deserialize: 'ids'
    }

`export default CoachSerializer`
