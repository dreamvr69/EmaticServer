`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'root', path: '/'
  @route 'sign-in'
  @route 'users'

  @route 'franchise', path: '/franchise/:id'
  @route 'edit-franchise', path: '/edit-franchise/:id'


  @route 'projects'
  @route 'notes'
  @route 'edit-project', path: 'edit-project/:id'
  @route 'edit-visualisation', path: 'edit-visualisation/:id'
  @route 'project-schedule', path: 'projects/:id/visualisations'

  @route 'schedule'

  @route 'clients'
  @route 'new-client'
  @route 'edit-client',   path: '/edit-client/:id'
  @route 'client',        path: '/client/:id'

`export default Router`
