

Presets = new Meteor.Collection("presets")


setPreset = (name) ->
  if name
    location.hash = name
    unless Session.equals 'current', name
      console.log 'loading', name
      p = Presets.findOne
        name: name
      console.log p
      json = JSON.parse p.data
      g = Dataflow.loadGraph json
      g.trigger 'change'
      Session.set 'current', name



Template.funky.events
  'click #save': ->
    console.log 'save'
    preset = Dataflow.graph.toJSON()
    name = $('#name').val()
    Presets.insert
      data: JSON.stringify(preset)
      name: name


  'click #presets': (e) ->
    name = e.toElement?.id
    setPreset name


Template.funky.presets = ->
  Presets.find {}

Template.funky.current = ->
  Session.get 'current'



Meteor.startup ->
  Session.set 'current', ''
  name = location.hash?.slice(1)
  Meteor.setTimeout (-> setPreset name), 1000



