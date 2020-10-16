﻿# TaoDragBorder
https://zhuanlan.zhihu.com/p/89243630

Qt/qml实现的可拖拽边框，支持改变大小、坐标及旋转角度

# 效果图

![1](1.gif)

# 使用

封装的组件名称是TemplateBorder。

使用很简单，在要支持拖拽的目标组件上，创建一个TemplateBorder实例即可，例如：

```qml
    Rectangle {
        x: 100
        y: 200
        width: 300
        height: 200
        color: "red"
        smooth: true
        antialiasing: true
        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.focus = true
            }
        }
        //这里添加一个边框
        TemplateBorder {
            //注意控制大小
            width: parent.width + borderMargin * 2
            height: parent.height + borderMargin * 2
            anchors.centerIn: parent
            //目标item有焦点时显示边框
            visible: parent.focus
        }
    }
```

# 原理

## 拖拽的前提

目标组件不要用锚布局，不要用Layout布局。

拖拽需要修改目标组件的坐标和宽高，而锚布局、Layout会限定坐标或宽高。

## 拖拽原理

拖拽本身可以使用MouseArea的 drag.target，但这个target限制为item及其子类。

有时候还需要处理无边框窗口的拖动，窗口不是item，就不能用drag.target。

所以需要一个通用的拖拽算法：
```qml
    ...
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        property int lastX: 0
        property int lastY: 0
        onPressedChanged: {
            if (containsPress) {
              //按下鼠标时记录坐标
                lastX = mouseX;
                lastY = mouseY;
            }
        }
        onPositionChanged: {
            if (pressed) {
              //拖动时修改目标的坐标
                parent.x += mouseX - lastX
                parent.y += mouseY - lastY
            }
        }
    }
    ...
```
## 锚点

锚点就是在组件的左上角、右上角等八个点，分别放一个小圆圈，圆圈里面是可拖拽组件，分别控制组件的坐标、宽高。

注意每个点的计算规则都不太一样。

例如左上角，要同时计算x、y和宽高，而右上角则只计算y、和宽高：

```

Item {
    id: root
    //controller 要控制大小的目标，可以是Item，也可以是view，只要提供x、y、width、height等属性的修改
    //默认值为parent
    property var control: parent
    //左上角的拖拽
    TDragItem {
        id: leftTopHandle
        posType: posLeftTop
        onPosChange: {
            if (control.x + xOffset < control.x + control.width)
                control.x += xOffset;
            if (control.y + yOffset < control.y + control.height)
                control.y += yOffset;
            if (control.width - xOffset > 0)
                control.width-= xOffset;
            if (control.height -yOffset > 0)
                control.height -= yOffset;
        }
    }
    //右上角拖拽
    TDragItem {
        id: rightTopHandle
        posType: posRightTop
        x: parent.width - width
        onPosChange: {
            //向左拖动时，xOffset为负数
            if (control.width + xOffset > 0)
                control.width += xOffset;
            if (control.height - yOffset > 0)
                control.height -= yOffset;
            if (control.y + yOffset < control.y + control.height)
                control.y += yOffset;
        }
    }
    ...
    ...
}
```
## 旋转

旋转算法和拖拽类似
```
    MouseArea {
        id: rotateArea
        anchors.centerIn: parent
        property int lastX: 0

        onPressedChanged: {
          if (containsPress) {
            lastX = mouseX;
          }
        }
        onPositionChanged: {
          if (pressed) {
            let t = controller.rotation +(mouseX - lastX) / 5
            //这里的除以5，用来消除抖动。
            t = t % 360
            controller.rotation = t
          }
        }
    }
```

# 开发环境

* Qt 5.12.x

## 答疑和技术支持

QQ群：734623697

## 联系方式


| 作者 | 涛哥                           |
| ---- | -------------------------------- |
|开发理念 | 传承工匠精神 |
| 博客 | https://jaredtao.github.io/ |
|博客-国内镜像|https://jaredtao.gitee.io|
|知乎专栏| https://zhuanlan.zhihu.com/TaoQt |
|微信公众号| Qt进阶之路 |
|QQ群| 734623697(高质量群，只能交流技术、分享书籍、帮助解决实际问题）|
| 邮箱 | jared2020@163.com                |
| 微信 | xsd2410421                       |
| QQ、TIM | 759378563                      |

QQ(TIM)、微信二维码

<img src="https://gitee.com/jaredtao/jaredtao.gitee.io/blob/master/img/qq_connect.jpg?raw=true" width="30%" height="30%" /><img src="https://gitee.com/jaredtao/jaredtao.gitee.io/blob/master/img/weixin_connect.jpg?raw=true" width="30%" height="30%" />

请放心联系我，乐于提供咨询服务，也可洽谈有偿技术支持相关事宜。 


## 赞助

<img src="https://gitee.com/jaredtao/jaredtao.gitee.io/blob/master/img/weixin.jpg?raw=true" width="30%" height="30%" /><img src="https://gitee.com/jaredtao/jaredtao.gitee.io/blob/master/img/zhifubao.jpg?raw=true" width="30%" height="30%" />

觉得分享的内容还不错, 就请作者喝杯奶茶吧~~
