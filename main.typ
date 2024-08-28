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

#set page(
    paper: "a5",
    margin: (x: 1cm, y: 1.5cm),
    header: [
      #h(1fr)
      #emph[Daily Planner of NK]
      #h(1fr)
    ],
    footer: locate(loc => {
      let i = counter(page).at(loc).first()
      let before = query(selector(heading).before(loc), loc)

      if before != () {
        if calc.odd(i) {
          return [
            #h(1fr)
            #smallcaps(before.last().body.children.at(1).child)
          ]
        }

        return [
          #smallcaps(before.last().body.children.at(1).child)
        ]
      }
    })
)

#let year = 2024
#let max_days = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

#let heading_height = 24pt


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

    box(height: 251pt)[
      #line(length: 100%, stroke: 1pt + cmyk(0%, 100%, 0%, 0%))
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

      day = day + 1
    }

  pagebreak()
  month = month + 1
}
