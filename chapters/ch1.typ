= Introduction

Autonomous robots are transforming the way we approach work in different fields such as logistics, healthcare, agriculture, environmental control, rescue, and so on. Even though they are becoming part of our everyday life, robotics still poses open challenges spanning diverse disciplines: mechanical engineering, control engineering, perception, and planning, just to say some.

The focus of this course will be on _robot autonomy_, that is, empowering robots to perceive their environment, acquire knowledge, and make task-oriented decisions.

== Autonomous Robots

Let's start from the beginning: the word _robot_ comes from the Czech word *robota*, meaning _forced labor_. The word _autonomous_ comes from the Greek words *auto* (self) and *nomos* (law), and can be interpreted as _self-governing_.

Robots are made of rigid bodies, also called *links*, connected by *joints* that are *actuated* in order to move. The most common way of actuation is using electic motors, but other mechanisms exists such as pneumatic or hydraulic cylinders.

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

A robot can be defined as the integration of multiple subsystems, each devoted to one or more
specific subproblems.

== Open Loop Operation



// TO REVIEW: Open loop operation
// TO REVIEW: The agent view + detailed
// TO REVIEW: The uncertainty cycle
// TO REVIEW: Dynamical system equations
// TO REVIEW: Objective
