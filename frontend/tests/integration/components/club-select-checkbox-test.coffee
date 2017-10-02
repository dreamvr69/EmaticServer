`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'club-select-checkbox', 'Integration | Component | club select checkbox', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{club-select-checkbox}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#club-select-checkbox}}
      template block text
    {{/club-select-checkbox}}
  """

  assert.equal @$().text().trim(), 'template block text'
