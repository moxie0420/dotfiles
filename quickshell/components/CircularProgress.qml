import QtQuick
import qs.services

Item {
  id: root

  property list<real> animationCurve: Easings.standard
  property int animationDuration: Easings.standardTime
  property int degreeLimit: 360
  property int lineWidth: 5
  property color primaryColor: Colors.current.pine
  property color secondaryColor: Colors.current.base
  property int size: 150
  property real value: 0

  height: size
  width: size

  Canvas {
    id: canvas

    property real degree: root.degreeLimit * root.value

    anchors.fill: parent
    antialiasing: true

    Behavior on degree {
      NumberAnimation {
        duration: root.animationDuration
      }
    }

    onDegreeChanged: {
      requestPaint();
    }
    onPaint: {
      let ctx = getContext("2d");

      let x = root.width / 2;
      let y = root.height / 2;

      let radius = root.size / 2 - root.lineWidth;
      let startAngle = (Math.PI / 180) * 270;
      let fullAngle = (Math.PI / 180) * (270 + root.degreeLimit);
      let progressAngle = (Math.PI / 180) * (270 + degree);

      ctx.reset();

      ctx.lineCap = 'round';
      ctx.lineWidth = root.lineWidth;

      ctx.beginPath();
      ctx.arc(x, y, radius, startAngle, fullAngle);
      ctx.strokeStyle = root.secondaryColor;
      ctx.stroke();

      ctx.beginPath();
      ctx.arc(x, y, radius, startAngle, progressAngle);
      ctx.strokeStyle = root.primaryColor;
      ctx.stroke();
    }
  }
}
