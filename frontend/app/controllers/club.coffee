`import Ember from 'ember'`

ClubController = Ember.Controller.extend

  baseServices:  Ember.computed.filterBy 'model.services', 'type', 'base'
  extraServices: Ember.computed.filterBy 'model.services', 'type', 'extra'

`export default ClubController`
