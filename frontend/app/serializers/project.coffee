`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ProjectSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    visualisations: {
      serialize: 'ids',
      deserialize: 'ids'
    }

`export default ProjectSerializer`
