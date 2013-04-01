

Presets = new Meteor.Collection("presets")


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
    if name
      console.log 'loading', name
      p = Presets.findOne
        name: name
      json = JSON.parse p.data
      g = Dataflow.loadGraph json
      g.trigger 'change'

Template.funky.presets = ->
  Presets.find {}

Template.funky.current = ->
  Session.get 'current'