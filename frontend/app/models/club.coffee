`import DS from 'ember-data'`

Club = DS.Model.extend

  name:          DS.attr 'string'
  description:   DS.attr 'string'
  phone:         DS.attr 'string'
  address:       DS.attr 'string'
  websiteLink:   DS.attr 'string'

  vkLink:        DS.attr 'string'
  twitterLink:   DS.attr 'string'
  facebookLink:  DS.attr 'string'
  instagramLink: DS.attr 'string'

  vkShareScore:        DS.attr 'number'
  twitterShareScore:   DS.attr 'number'
  facebookShareScore:  DS.attr 'number'
  instagramShareScore: DS.attr 'number'

  vkSharePerDay:        DS.attr 'number'
  twitterSharePerDay:   DS.attr 'number'
  facebookSharePerDay:  DS.attr 'number'
  instagramSharePerDay: DS.attr 'number'

  firstLevelMinScore:  DS.attr 'number'
  secondLevelMinScore: DS.attr 'number'
  thirdLevelMinScore:  DS.attr 'number'
  fourthLevelMinScore: DS.attr 'number'
  fifthLevelMinScore:  DS.attr 'number'
  maxScorePerDay:      DS.attr 'number'

  clubShedule:   DS.belongsTo 'club/shedule'
  cardTemplates: DS.hasMany 'card/template'
  franchise:     DS.belongsTo 'franchise'
  selectedAdmin: DS.belongsTo 'user', { inverse: 'selectedClub' }
  users:         DS.hasMany   'user'
  clubImages:    DS.hasMany   'club/image'

  services:      DS.hasMany 'service'

`export default Club`
