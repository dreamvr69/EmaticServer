`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`

ClientsController = Ember.Controller.extend ToastMixin,
  session: Ember.inject.service()
  queryParams: ['scope', 'page', 'perPage']
  scope: 'clients'
  page: 1
  perPage: 10

  paginationContent: Ember.computed 'model.meta.current_page', 'model.meta.total_pages', ->
    {
      page: @get('model.meta.current_page')
      totalPages: @get('model.meta.total_pages')
    }

  isPaginationEnabled: Ember.computed.gt 'model.meta.total_pages', 1

  actions:
    changePage: (num) ->
      @set('page', num)

    show: (client) ->
      @transitionToRoute 'client', client.id

    edit: (client) ->
      @transitionToRoute 'edit-client', client.id

    destroy: (client) ->
      if confirm('Удалить клиента?')
        client.destroyRecord()
        @showToast('Клиент удален!')

`export default ClientsController`
