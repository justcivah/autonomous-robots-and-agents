#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Introduction

Autonomous robots are transforming the way we approach work in different fields such as logistics, healthcare, agriculture, environmental control, rescue, and so on. Even though they are becoming part of our everyday life, robotics still poses open challenges spanning diverse disciplines: mechanical engineering, control engineering, perception, and planning, just to say some.

The focus of this course will be on _robot autonomy_, that is, empowering robots to perceive their environment, acquire knowledge, and make task-oriented decisions.

== Autonomous Robots

Let's start from the beginning: the word _robot_ comes from the Czech word *robota*, meaning _forced labor_. The word _autonomous_ comes from the Greek words *auto* (self) and *nomos* (law), and can be interpreted as _self-governing_.

With the concept of autonomy, we move away from the classical automation problem where a system can operate in a predefined way and location, and we make the robot independent in dynamic and uncertain environments.

Their autonomy makes them particularly useful in scenarios where human intervention is not possible, inefficient, or dangerous. Some examples may be natural disasters, contaminated sites, deep sea or space exploration, and more in general hazardous environments. At the same time, autonomy makes complex operation possible, without the need of continuous human intervention.

A robot can be autonomous by perceiving its surrounding environment. That is possible thanks different types of sensors that provide informations about the world. Common examples include RGB-D cameras, capturing images and depth informations, LiDAR sensors, measuring distances thanks to laser pulses, and ultrasonic sensors, emitting high-frequency sound waves that measure distance.

== Robot Families

There are two main families of robots:

- *Mobile robots:* a robot not constrained to remain in a pre-assigned area, that is able to operate in either structured or unstructured environments. They can move in different ways, all of them somehow inspired by nature: they can walk, run, jump, slide, roll and fly. But there is one exception: the actively powered wheel was invented by humans and is extremely efficient on flat ground.

- *Fixed robots:* a robot anchored to a fixed location in space, typically deployed in structured environments. This is the most common type of robot used in assembly lines and industrial automation, and are designed to do repetitive tasks such as welding, assembly, and painting. Compared with mobile robots they usually have more stability, greater payload capacity, and precision. Given their size, humans can't enter in their working area for safety reasons. On the other hand, cooperative robots (*cobots*), can work with humans as they are smaller in size and have sensors capable of stopping when touching an obstacle.

== Structured and Unstructured Environments

A *structured environment* is one that is predictable, well-defined, and largely static. Obstacles, surfaces, and operational conditions are known in advance and do not change significantly over time. A factory floor with fixed machinery and clearly delimited workspaces is a typical example.

An *unstructured environment*, by contrast, is dynamic, partially unknown, and potentially
unpredictable. The robot doesn't usually have a prior precise map of its surroundings he can rely on. Instead it senses and adapts to the environment at runtime. Some examples are outdoor settings, private houses, public spaces, and natural terrains. These types of environments are much harder to work in compared to the structured ones.

== Course Focus

The course will primarily focus on mobile robots, and in particular on those main problems:

- *Localization:* estimate the robot position and location in its working environment.
- *Navigation:* moving from one location to another in a safe and efficient way.
- *Planning:* compute a sequence of actions in order to achieve a certain goal.

A robot can be defined as the integration of multiple subsystems, each devoted to one or more specific subproblems.

== Open Loop Operation

The open loop operation is one of the easiest way a robot can operate. It consists in executing pre-defined commands, without taking feedbacks from the environment. This means they cannot adjust their actions, but just assume the environment behaves as excpected. These types of robots have no sensors, and can only work in structured or highly predictable environments. They are useful for simple and repetitive tasks, such as pre-programmed assembly line, and fixed-path industrial painting.

In open loop operation, all possible conditions must be considered in advance, as the robot cannot adapt to unexpected changes in the environment. Because of this, the robot can't be considered autonomous, as it relies only on prior programming instead of real time planning. A simple scheme showing the open loop architecture is shown in @open_loop_architecture.

#figure(
  gap: 1.5em,
  placement: auto,
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

These two perspectives are complementary rather than alternative: closed loop operation describes the control structure of the system, focusing on how feedback is used to control execution; the agent view describes the cognitive structure, focusing on how decisions are derived from perceptions in order to reach a goal. They operate at different abstraction levels. An example of the agent view architecture is shown in @agent_view_architecture.

#figure(
  gap: 1.5em,
  placement: auto,
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

A more detailed agent view diagram is shown in @agent_view_detailed, where the loop is described at the signal level. Here, the environment is described using an internal state *x*. Decisions are taken based on that information, and actuators apply a control action *u* perturbed by some disturbances, before reaching the environment. Sensors observe the state producing some measurements *z*, which are also affected by some hardware disturbances. Also the environment can be affected by some disturbances, such as weather conditions or moving obstacles.

#figure(
  gap: 1.5em,
  placement: auto,
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
    edge(<disturbance_1>, <environment>, "-}>", "wave", stroke: 1pt),
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

== The Uncertainty Cycle

In a perfect world, if you tell a robot to move one meter, it will move exactly by that distance. But as the disturbances in @agent_view_detailed illustrate, a real environment is affected by some disturbance, which may interfere with robot actions and sensing operations. For example, if the robot has to move by one meter, it will probably end up with at a slightly different position from the one meter marker. This difference between the _intended_ state and the _actual_ one, is driven by the uncertainty cycle, a continuous loop where actions accumulate uncertainty and perceptions correct it.

Let's examine each phase in detail:

- *Actions increase uncertainty:* when a robot executes an action, uncertainty about its state grows. Even with precise control actions, each action performed will differ from the expected one. That's mainly because of actuators inaccuracy at executing commands, wheel slippage, and unexpected obstables in the environment. The more actions the robot executes without feedbacks from the environment, the more the uncertainty will accumulate.

- *Perceptions decrease uncertainty:* sensing the environment allows the robot to reduce the uncertainty by comparing what he sees with what he expects to see. Some examples can be the distance from a wall, the detection of a set of features or a known landmark in the environment. However, we also have to consider that sensors may be affected by disturbances.

== Dynamical System Equations

To formalize how robots interact with their environment, we model them as dynamical systems. A dynamical system describes how the state of the robot evolves over time in response to control inputs, and how observations are obtained from that state.

There are two main equations to model that system behavior:

- *State-transition equation* $f$: describes how the state evolves over time as a function of the current state and control inputs. This captures the robot's dynamics, like how its position changes when wheels turn.
- *Observation equation* $h$: describes how sensor measurements relate to the current state. This maps the robot's actual state to what the sensors perceive. For example an image taken from a camera depends on the robot current orientation.

=== Time-Variant and Time-Invariant

Dynamical systems can be divided into two main categories: *time-variant* and *time-invariant* systems. In the former the dynamics depend on time, while in the latter, dynamics do not change over time.

Time-variant systems:

#v(5pt)
#grid(
  columns: (1fr, 1fr),
  rows: auto,
  align: center,
  gutter: 1em,
  [*Continuous Time*, $t in RR^+$], [*Discrete time*, $t in NN$],
  [$dot(bold(x)) = f(bold(x), bold(u), t)$], [$bold(x_t) = f(bold(x_(t-1)), bold(u_(t-1)), t)$],
  [$bold(z) = h(bold(x), bold(u), t)$], [$bold(z) = f(bold(x_t), bold(u_t), t)$],
)
#v(10pt)

Time-invariant systems:

#v(5pt)
#grid(
  columns: (1fr, 1fr),
  rows: auto,
  align: center,
  gutter: 1em,
  [*Continuous Time*, $t in RR^+$], [*Discrete time*, $t in NN$],
  [$dot(bold(x)) = f(bold(x), bold(u))$], [$bold(x_t) = f(bold(x_(t-1)), bold(u_(t-1)))$],
  [$bold(z) = h(bold(x), bold(u))$], [$bold(z) = f(bold(x_t), bold(u_t))$],
)
#v(10pt)

Notice that time can also be modeled as continuous or discrete, based on how the system evolves, and how observations and updates are made. In continuous-time models $dot(bold(x))$ is the derivative, and represents how the system changes over time.

=== State Evolution

Consider a robot starting from initial state $bold(x)_0$. A starting control input $bold(u_1)$ is given, and the state evolves into $bold(x)_1 = f(bold(x)_0, bold(u)_1)$. In this state, a sensor measurement $h(bold(x_1))$ is obtained. Then, the next control input $bold(u_2)$ is applied, and the state $bold(x)_2 = f(bold(x)_1, bold(u)_2)$ is reached. At this new state, a sensor measurement $bold(z)_1 = h(bold(x)_1)$ is obtained. Applying the next control input $bold(u)_2$ yields $bold(x)_2 = f(bold(x)_1, bold(u)_2)$, and so on. This process continues as:

#figure(
  placement: none,
  diagram(
    spacing: (10pt, 10pt),

    // styles
    let text_style = (
      inset: 8pt,
    ),

    // nodes
    node((0, 0), ..text_style, align(center)[$bold(x_0)$]),
    node((1, 0), ..text_style, align(center)[$bold(x_1) = f(bold(x_0), bold(u_1))$]),
    node((2, 0), ..text_style, align(center)[$bold(x_2) = f(bold(x_1), bold(u_2))$]),
    node((3, 0), ..text_style, align(center)[...]),
    node((4, 0), ..text_style, align(center)[$bold(x_n) = f(bold(x_(n-1)), bold(u_n))$]),
    node((0.55, 1), ..text_style, align(left)[$h(bold(x_1))$]),
    node((1.7, 1), ..text_style, align(left)[$h(bold(x_2))$]),
    node((3.48, 1), ..text_style, align(left)[$h(bold(x_n))$]),

    // edges
    edge((0, 0), (1, 0), "->", stroke: 0.6pt, text(size: 9pt, style: "italic")[$u_1$]),
    edge((1, 0), (2, 0), "->", stroke: 0.6pt, text(size: 9pt, style: "italic")[$u_2$]),
    edge((2, 0), (3, 0), "->", stroke: 0.6pt, text(size: 9pt, style: "italic")[$u_3$]),
    edge((3, 0), (4, 0), "->", stroke: 0.6pt, text(size: 9pt, style: "italic")[$u_n$]),
    edge((0.55, 0), (0.55, 1), "=>", stroke: 0.6pt),
    edge((1.7, 0), (1.7, 1), "=>", stroke: 0.6pt),
    edge((3.5, 0), (3.48, 1), "=>", stroke: 0.6pt),
  ),
) <state_evolution>
#v(10pt)

These equations represents a way for reasoning about robot behaviors, and will play a central role for tasks like localization, navigation, and planning algorithms.
