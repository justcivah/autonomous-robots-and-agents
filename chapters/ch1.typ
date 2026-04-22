= Introduction

Autonomous robots are poised to transform fields such as logistics, healthcare, and precision
agriculture. Robotics still poses open challenges spanning diverse disciplines: mechanical
engineering, control engineering, perception, planning, and more.

The focus of this course will be on _robot autonomy_, that is, empowering robots to perceive
their environment, acquire knowledge, make task-oriented decisions, and learn.

== Autonomous Robots

The word _robot_ comes from the Czech word *robota*, meaning forced labor. The word _autonomous_
comes from the Greek words *auto* (self) and *nomos* (law), and is today interpreted as
"self-governing."

== Robot Families

There are two main families of robots:

- *Mobile Robots:* a robot not constrained to remain in a pre-assigned area, which may operate
  in either structured or unstructured environments.

- *Fixed Robots:* anchored to a fixed location in space, typically deployed in structured
  environments.

=== Structured and Unstructured Environments

A *structured environment* is one that is predictable, well-defined, and largely static.
Obstacles, surfaces, and operational conditions are known in advance and do not change
significantly over time. A factory floor with fixed machinery and clearly delimited workspaces
is a canonical example.

An *unstructured environment*, by contrast, is dynamic, partially unknown, and potentially
unpredictable. The robot cannot rely on a precise prior map of its surroundings and must
instead sense and adapt to the environment at runtime. Outdoor settings, public spaces, and
natural terrain are typical examples.

== Course Focus: Mobile Robots

The course will primarily focus on mobile robots. The key functionalities — or problems — that
will be addressed are:

- *Localization:* estimating the robot's position and orientation within its environment.
- *Navigation:* moving from one location to another safely and efficiently.
- *Planning:* computing sequences of actions that achieve a given task objective.

A robot can be defined as the integration of multiple subsystems, each devoted to one or more
specific subproblems.

// TO REVIEW: Open loop operation
// TO REVIEW: The agent view + detailed
// TO REVIEW: The uncertainty cycle
// TO REVIEW: Dynamical system equations
// TO REVIEW: Objective
