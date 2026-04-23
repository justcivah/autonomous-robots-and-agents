#let conf(
  title: none,
  ay: none,
  author1: none,
  author2: none,
  reviewer: none,
  doc,
) = {
  set document(title: title, author: (author1, author2))

  set page(
    paper: "a4",
    margin: (x: 3cm, y: 3cm),
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: luma(80))
        grid(
        columns: (1fr, 1fr),
        align(left)[#title],
        align(right)[#ay],
      )
      }
    },
  )

  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.72em, spacing: 1.1em)
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    v(1.6em)
    text(size: 16pt, weight: "bold")[#it]
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(1.0em)
    text(size: 13pt, weight: "bold")[#it]
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    v(0.8em)
    text(size: 11pt, weight: "bold")[#it]
    v(0.2em)
  }

  // cover page
  set page(numbering: none)
  align(center + horizon)[
    #text(size: 10pt, fill: luma(80), tracking: 1.5pt)[#upper[Lecture Notes] · #ay]
    #v(2em)
    #text(size: 22pt, weight: "bold")[#title]
    #v(1.2em)
    #text(size: 11pt)[#author1 #h(0.8em) · #h(0.8em) #author2]
    #v(0.5em)
    #if reviewer != none {
      text(size: 10pt, fill: luma(80))[Reviewed by #reviewer]
    }
  ]

  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)

  doc

}

// apply templeate
#show: conf.with(
  title: "Autonomous Robots and Agents",
  ay: "A.Y. 2025/2026",
  author1: "Alessandro Bordonali",
  author2: "Giovanni Novati",
  reviewer: "Prof. Nicola Basilico",
)

#outline()
#pagebreak()

#set heading(numbering: (..x) => numbering("1.", ..x.pos().map(n => n - 1)))

#include "chapters/ch0.typ"
#include "chapters/ch1.typ"
