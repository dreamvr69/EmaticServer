`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`

ProjectsController = Ember.Controller.extend ToastMixin,
  session: Ember.inject.service()
  queryParams: ['scope', 'page', 'perPage']
  scope: null
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

    open: (news) ->
      @transitionToRoute 'show-news', news.id

    show: (news) ->
      news.set 'isOnSlider', true
      news.save()
      $('.material-tooltip').remove()
      $('.tooltipped').tooltip({delay: 50})
      @showToast('Новость показана пользователям!')

    hide: (news) ->
      news.set 'isOnSlider', false
      news.save()
      $('.material-tooltip').remove()
      $('.tooltipped').tooltip({delay: 50})
      @showToast('Новость скрыта от пользователей!')

    edit: (project) ->
      @transitionToRoute 'edit-project', project.id

    destroy: (news) ->
      if confirm('Удалить новость?')
        news.destroyRecord()
        @showToast('Новость успешно удалена!')

`export default ProjectsController`
