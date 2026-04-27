#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Introduction

Autonomous robots are transforming the way we approach work in different fields such as logistics, healthcare, agriculture, environmental control, rescue, and so on. Even though they are becoming part of our everyday life, robotics still poses open challenges spanning diverse disciplines: mechanical engineering, control engineering, perception, and planning, just to say some.

The focus of this course will be on _robot autonomy_, that is, empowering robots to perceive their environment, acquire knowledge, and make task-oriented decisions.

== Autonomous Robots

Let's start from the beginning: the word _robot_ comes from the Czech word *robota*, meaning _forced labor_. The word _autonomous_ comes from the Greek words *auto* (self) and *nomos* (law), and can be interpreted as _self-governing_.

With the concept of autonomy, we move away from the classical automation problem where a system can operate in a predefined way and location, and we make the robot independent in dynamyc and uncertain environments.

Their autonomy makes them particularly useful in scenarios where human intervention is not possible, inefficient, or dangerous. Some examples may be natural disasters, contaminated sites, deep sea or space exploration, and more in general in hazardous environments. At the same time, autonomy makes complex operation possible, without the need of continuous human intervention.

A robot can be autonomous by perceiving its surrounding environment. That is possible thanks different types of sensors that provide informations about the world. Common examples include RGB-D camerat, capturing images and depth informations, LiDAR sensors, measuring distances thanks to laser pulses, and ultrasonic sensors, emitting high-frequency soud waves that measure distance.

== Robot Families

There are two main families of robots:

- *Mobile robots:* a robot not constrained to remain in a pre-assigned area, that is able to operate in either structured or unstructured environments. They can move in different ways, all of them somehow inspired by nature: they can walk, run, jump, slide, roll and fly. But there is one exception: the actively powered wheel was invented by humans and is extremely efficient on flat ground.

- *Fixed robots:* a robot anchored to a fixed location in space, typically deployed in structured environments. This is the most common type of robot used in assembly lines and industrial automation, and are designed to do repetitive tasks such as weliding, assembly, and painting. Compared with mobile robots they usually have more stability, greater payload capacity, and precision. Given their size, humans can't enter in their working area for safety reasons. On the other hand, cooperative robots (*cobots*), can work with humans as they are smaller in size and have sensors capable of stopping when touching an obstacle.

== Structured and Unstructured Environments

A *structured environment* is one that is predictable, well-defined, and largely static. Obstacles, surfaces, and operational conditions are known in advance and do not change significantly over time. A factory floor with fixed machinery and clearly delimited workspaces is a typical example.

An *unstructured environment*, by contrast, is dynamic, partially unknown, and potentially
unpredictable. The robot doesn't usually have a prior precise map of its surroundings he can rely on. Instead it senses and adapts to the environment at runtime. Some examples are outdoor settings, private houses, public spaces, and natural terrains. These types of environments are much harder to work in compared to the structured ones.

== Course Focus: Mobile Robots

The course will primarily focus on mobile robots, and we will focus on those main problems:

- *Localization:* estimate the robot position and location in it's working environment.
- *Navigation:* moving from one location to another in a safe and efficient way.
- *Planning:* compute a sequence of actions in order to achieve a certain goal.

A robot can be defined as the integration of multiple subsystems, each devoted to one or more specific subproblems.

== Open Loop Operation

The open loop operation is one of the easiest way a robot can operate. It consists in executing pre-defined commands, without taking feedbacks from the environment. This means that they cannot adjust their actions, but just assume the environment behaves as excpected. These types of robots have no sensors, and can only work in structured or highly predictable environments. They are useful for simple and repetitive tasks, such as pre-programmed assembly line, and fixed-path industrial painting.

In open loop operation, all possible conditions must be considered in advance, as the robot cannot adapt to unexpected changes in the environment. Because of this, the robot can't be considered autonomous, as it relies only on pre prior programming instead of real time planning. A simple scheme showing the open loop architecture is shown in @open_loop_architecture.

#figure(
  gap: 1.5em,
  diagram(
    spacing: (60pt, 20pt),
    node-corner-radius: 8pt,

    // nodes
    node((0, 0), align(center)[*Control Software*], inset: 10pt),
    node((1, 0), align(center)[*Actuators*], inset: 10pt),
    node((2, 0), align(center)[*Environment*], inset: 10pt),

    // styles
    let robot_box = (
      stroke: (paint: rgb("#2f5db4"), thickness: 1pt, dash: "dashed"),
      fill: rgb("#eef3ff"),
      inset: 17pt,
    ),
    let component_style = (
      stroke: rgb("#2f5db4") + 1pt,
      fill: white,
      inset: 7pt,
    ),
    let environment_style = (
      stroke: rgb("#1a7a52") + 1pt,
      fill: rgb("#ecf9f3"),
      inset: 7pt,
    ),

      node(enclose: ((0, 0), (1, 0)), ..robot_box),
      node(enclose: ((0, 0), (0, 0)), ..component_style),
      node(enclose: ((1, 0), (1, 0)), ..component_style, name: <actuators>),
      node(enclose: ((2, 0), (2, 0)), ..environment_style, name: <environment>),

      // edges
      edge((0, 0), (1, 0), "-}>", stroke: 1pt, text(size: 9pt, style: "italic")[commands]),
      edge(<actuators>, <environment>, "->", stroke: red + 1.5pt, text(size: 9pt, style: "italic")[actions]),
  ),
  caption: [
    Open loop control architecture.
  ],
) <open_loop_architecture>

== Closed Loop Operation and Agent View

Unlike pre-programmed robots that operate with an open loop approach, intelligent systems typically rely on feedback perceived from the environment in order to adapt to changes and uncertanties. This is the main idea behind the closed loop operation, where the system monitors the effect of its actions on the environment and adapt.

From an agent view, the robot is considered an entity that interacts with the environment in two main ways:

- *Perception:* the agent acquires informations about the environment using sensors.

- *Action:* the agent uses its actuators to affect the state of the environment.

Formally, an agent can be viewed as a function that maps perceptions to actions.

These two perspectives are complementary rather than alternative: closed loop operation describes the control structure of the system, focusing on how feedback is used to control execution; the agent view describes the cognitive structure, focusing on how decisions are derived from perceptions in order to reach a goal. They operate at different abstraction levels.

An example of the agent view architecture is shown in @agent_view_architecture

#figure(
  gap: 1.5em,
  diagram(
    spacing: (-5pt, 25pt),
    node-corner-radius: 8pt,

    // styles
    let robot_box = (
      stroke: (paint: rgb("#2f5db4"), thickness: 1pt, dash: "dashed"),
      fill: rgb("#eef3ff"),
      inset: 34pt,
    ),
    let component_style = (
      stroke: rgb("#2f5db4") + 1pt,
      fill: white,
      inset: 20pt,
    ),
    let sub_component_style = (
      stroke: rgb("#2f5db4") + 1pt,
      fill: white,
      inset: 10pt,
    ),
    let environment_style = (
      stroke: rgb("#1a7a52") + 1pt,
      fill: rgb("#ecf9f3"),
      inset: 20pt,
    ),

    // nodes
    // robot
    node((0, 0), none),
    node((1, 0), none),
    node((0, 1), none),
    node((1, 1), none),
    node((0, 2), none),
    node((1, 2), none),
    // environment
    node((0, 3.8), none),
    node((1, 3.8), none),

    // composition
    node(enclose: ((0, 0), (1, 2)), ..robot_box, name: <robot>, width: 238pt),
    node(enclose: ((0, 0), (1, 0)), ..component_style, name: <cognition>, align(center)[*Cognition*], width: 217pt),
    node(enclose: ((0, 1), (1, 1)), ..component_style,  name: <navigation>, align(center)[*Navigation*], width: 217pt),
    node(enclose: ((0, 2), (0, 2)), ..component_style,  name: <perception>, align(center)[*Perception*], width: 102pt),
    node(enclose: ((1, 2), (1, 2)), ..component_style,  name: <actuators>, align(center)[*Actuators*], width: 102pt),
    node(enclose: ((0, 3.8), (1, 3.8)), name: <environment>, align(center)[*Environment*], ..environment_style),

    // edges
    edge(<cognition>, <navigation>, "<{-}>", stroke: 1pt),
    edge((0, 1), <perception>, "<{-}>", stroke: 1pt),
    edge((1, 1), <actuators>, "<{-}>", stroke: 1pt),
    edge(<actuators>, (1, 3.8), "->", stroke: red + 1.5pt, text(size: 9pt, style: "italic")[actions], left),
    edge((0, 3.8), <perception>, "->", stroke: red + 1.5pt, text(size: 9pt, style: "italic")[perceptions], left),
  ),
  caption: [
    Agent view architecture.
  ],
) <agent_view_architecture>

#figure(
  gap: 1.5em,
  diagram(
    spacing: (20pt, 40pt),
    node-corner-radius: 8pt,

    // styles
    let component_style = (
      stroke: rgb("#2f5db4") + 1pt,
      fill: white,
      inset: 10pt,
    ),
    let disturbance_style = (
      inset: 10pt,
    ),
    let sigma_style = (
      stroke: rgb("#000000") + 1.5pt,
      inset: 7pt,
    ),
    let environment_style = (
      stroke: rgb("#1a7a52") + 1pt,
      fill: rgb("#ecf9f3"),
      inset: 10pt,
    ),

    // nodes
    node((1, 0), ..disturbance_style,  name: <disturbance_1>, align(center)[#text(size: 9pt, style: "italic")[*Disturbances*]]),
    node((0, 1), ..component_style,  name: <actuators>, align(center)[#text(size: 9pt)[*Actuators*]], width: 70pt),
    node((1, 1), ..environment_style,  name: <environment>, align(center)[#text(size: 9pt)[*Environment*]]),
    node((2, 1), ..component_style,  name: <sensors>, align(center)[#text(size: 9pt)[*Sensors*]], width: 70pt),
    node((1, 1.6),  name: <control_software_name>, align(center)[#text(size: 12pt, style: "italic")[*x*]]),
    node((0, 2), ..sigma_style,  name: <sigma_1>, align(center)[#text(size: 12pt, style: "italic")[*$Sigma$*]]),
    node((1, 2), ..component_style,  name: <control_software>, align(center)[#text(size: 9pt)[*Control Software*]]),
    node((2, 2), ..sigma_style,  name: <sigma_2>, align(center)[#text(size: 12pt, style: "italic")[*$Sigma$*]]),
    node((0, 3), ..disturbance_style,  name: <disturbance_2>, align(center)[#text(size: 9pt, style: "italic")[*Disturbances*]]),
    node((2, 3), ..disturbance_style,  name: <disturbance_3>, align(center)[#text(size: 9pt, style: "italic")[*Disturbances*]]),

    // edges
    edge(<disturbance_1>, <environment>, "-}>", "wave", stroke: red + 1pt),
    edge(<actuators>, <environment>, "->", stroke: red + 1.3pt),
    edge(<environment>, <sensors>, "->", stroke: red + 1.3pt),
    edge(<sensors>, <sigma_2>, "-}>", stroke: 1pt),
    edge(<sigma_2>, <control_software>, "-}>", stroke: 1pt, text(size: 12pt, style: "italic")[*z*]),
    edge(<control_software>, <sigma_1>, "-}>", stroke: 1pt, text(size: 12pt, style: "italic")[*u*]),
    edge(<sigma_1>, <actuators>, "-}>", stroke: 1pt),
    edge(<disturbance_2>, <sigma_1>, "-}>", "wave", stroke: 1pt),
    edge(<disturbance_3>, <sigma_2>, "-}>", "wave", stroke: 1pt),
  ),
  caption: [
    Agent view detailed.
  ],
) <agent_view_detailed>

// TO REVIEW: The uncertainty cycle
// TO REVIEW: Dynamical system equations
// TO REVIEW: Objective
