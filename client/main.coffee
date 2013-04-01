

Presets = new Meteor.Collection("presets")


Template.funky.events
  'click #send': ->
    console.log 'send'
    preset = Dataflow.graph.toJSON()
    Presets.insert { data: JSON.stringify(preset) }

  'click #sync': ->
    console.log 'sync'
    p = Presets.findOne {}
    json = JSON.parse p.data
    g = Dataflow.loadGraph json
    g.trigger 'change'