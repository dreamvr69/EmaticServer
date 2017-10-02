`import Ember from 'ember'`
`import ToastMixin from '../mixins/toast-mixin'`
`import ScrollToTopMixin from '../mixins/scroll-to-top'`

ScheduleController = Ember.Controller.extend ToastMixin, ScrollToTopMixin,
  session: Ember.inject.service()
  store:   Ember.inject.service()

  filteredModels: Ember.computed.filterBy 'model', 'isNew', false
  selectedScheduleTemplate: null
  selectedDate: null

  events: Ember.computed 'filteredModels.@each.id', 'filteredModels.@each.title',
    'filteredModels.@each.begin', 'filteredModels.@each.end', ->
      @get('filteredModels').map (event) =>
        {
          id: event.get('id')
          title: event.get('event_name')
          start: event.get('begin')
          end: event.get('end')
          color: if ((event.get('state'))=="confirmed") then "#757575" else if((event.get('state'))=="booked") then"#757575" else "#009DA2"
          borderColor: if event.get('state')=='confirmed' then "#009DA2"
          borderWidth: '10px'
        }

  fcHeader: Ember.computed ->
    left: "month, agendaWeek, agendaDay",
    center: "title",
    right: "today, prev, next"


`export default ScheduleController`
