const bar = (monitor = 0) => Widget.Window({
  name: 'Bar',
  anchor: ['top', 'left', 'right'],
})

App.config({
  windows: [
    bar
  ]
})