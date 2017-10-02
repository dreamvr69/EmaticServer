`import Ember from 'ember'`

ItemSelectCheckbox = Ember.Component.extend

  itemSelected: false

  didInsertElement: ->
    if Ember.isPresent @get('items')
      if Ember.isPresent @get('items.content.canonicalState')
        if @get('item._internalModel') in @get('items.content.canonicalState')
          @set 'itemSelected', true
      else
        @set 'itemSelected',  @get('item') in @get('items')

  itemsObserver: Ember.observer 'items', 'items@each', 'items.length', ->
    if Ember.isPresent @get('items')
      if Ember.isPresent @get('items.content.currentState')
        @set 'itemSelected',  @get('item._internalModel') in @get('items.content.currentState')
      else
        @set 'itemSelected',  @get('item') in @get('items')

  itemSelectedObserver: Ember.observer 'itemSelected', ->
    if @get('itemSelected')
      @get('items').addObject(@get('item'))
    else
      @get('items').removeObject(@get('item'))

`export default ItemSelectCheckbox`

