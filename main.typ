#let smallcaps(body) = {
    set text(font: "MrsEavesSmallCaps")
    [#body]
}

#let numeric(body) = {
    set text(font: "MrsEavesSmallCaps")
    [#body]
}

#show emph: it => [
    #text(font: "MrsEaves", style: "italic", it.body)
]

#let strong(body) = {
  set text(font: "Mrs Eaves OT", weight: "bold")
  [#body]
}

#set text(font: "HQGQAX+MrsEavesOT-Roman", size: 12pt)

#let year = 2026
#let max_days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

#let heading_height = 24pt

#set page(width: 179mm, height: 254mm, margin: 15mm)

#page(align(center + top)[
    #rect(width: 100%, height: 100%, stroke: 0.5pt)[
      #v(6em)
      #text(16pt, tracking: 5pt, upper[
        Daily \
        Planner
      ])
      #line(length: 50%, stroke: 0.5pt + cmyk(0%, 100%, 0%, 0%))
      #text(14pt, tracking: 2pt, emph[
        Nayaab Khan
      ])
      #v(18em, weak: true)
      #text(18pt, smallcaps[
        #year
      ])
      #image("branch.svg", width: 120pt)
    ]
])

#pagebreak()
#pagebreak()

#set page(
    header: [
      #h(1fr)
      #emph[Daily Planner]
      #h(1fr)
    ],
    footer: locate(loc => {
      let i = counter(page).at(loc).first()
      let before = query(selector(heading).before(loc), loc)

      if before != () {
        if calc.odd(i) {
          return [
            #h(1fr)
            #emph(before.last().body.children.at(1).child)
            #smallcaps(year)
          ]
        }

        return [
          #emph(before.last().body.children.at(1).child)
          #smallcaps(year)
        ]
      }
    })
)

#let month = 1
#while month <= 12 {
  let day = 1

  let day_range = max_days.at(month - 1)
  while day <= day_range {
    let date = datetime(
      year: year,
      month: month,
      day: day,
    )

    box(height: 47%)[
      #line(length: 100%, stroke: 0.5pt + cmyk(0%, 100%, 0%, 0%))
      #align(
        center + top,
        strong(
          upper[
            #stack(dir: ltr, spacing: 16pt)[
              #box(width: 1fr, height: heading_height)[
                #set align(right + horizon)
                #text(10pt, tracking: 6pt)[
                  #date.display(
                    "[weekday repr:long]"
                  )
                ]
              ]
            ][
              #circle(fill: black, inset: 1pt, width: heading_height)[
                #set align(center + horizon)
                #numeric[
                  #text(18pt, tracking: -1pt, weight: "bold", fill: white)[
                    #date.display(
                      "[day padding:none]"
                    )
                  ]
                ]
              ]
            ][
              #box(width: 1fr, height: heading_height)[
                #set align(left + horizon)
                #heading[
                #text(10pt, tracking: 6pt)[
                  #date.display(
                    "[month repr:long]"
                  )
                ]
                ]
              ]
            ]
          ]
        )
      )
    ]

    v(0pt)

    day = day + 1
  }

  pagebreak()
  month = month + 1
}
