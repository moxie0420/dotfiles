const hyprland = await Service.import('hyprland')

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id")
  const workspaces = hyprland.bind("workspaces")
    .as(ws => ws.map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    })))

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  })
}

function Left() {
  return Widget.Box({
    spacing: 8,
    children: [
      Workspaces(),
    ],
  })
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [
    ],
  })
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [

    ],
  })
}


function Bar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: 'Bar${monitor}',
    class_name: "bar",
    anchor: ['top', 'left', 'right'],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}

App.config({
  windows: [
    Bar(0),
    Bar(1)
  ]
})