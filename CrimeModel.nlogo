; abm-crime
; Modelo baseado em agentes de crime - Netlogo 

; Crime and Economics Model
; Federal University of Paraná, Brazil
; NeX - Nucleo of Economics and Complexity
; Auhtors: João Basilio Pereima, Danilo Passos, Ana Carolina Novaes Silva
; Date: 20/01/2021
; -------------------------------------------------------------------------------------------------------


breed [ peoples people ]
breed [ babies baby ]                         ;; pink - under 6 year old inclusive
breed [ elderlies elderly ]                   ;; brown - people over 64 and not included in any other breeds
breed [ workers worker ]                      ;; green
breed [ unemployed_ unemployed ]              ;; orange, discouraged = red
breed [ thieves thieve ]                      ;; yellow
breed [ students student ]                    ;; magenta
breed [ cops cop ]                            ;; blue
breed [ prisoners prisoner ]                  ;; white
breed [ deads dead ]                          ;; just to remove turtles killed
breed [ schools school ]
breed [ firms firm ]
breed [ houses house ]
breed [ prisons prison ]

globals [
  year
  yearCalendar
  month
  day
  hour
  clock
  gini-index-reserve
  lorenz-points
  viol-deaths
  num-ticks
  wealth-ticks
  unemployment-rate
  g-houses-attempt-day            ; reseted once a day
  g-persons-attempt-day           ; reseted once a day
  g-houses-thefts-day             ; reseted once a day
  g-persons-thefts-day            ; reseted once a day
  g-avoided-thefts-day            ; reseted once a day
  g-avoided-house-day             ; reseted once a day
  g-avoided-person-day            ; reseted once a day
  g-houses-attempt-month          ; reseted once a month
  g-persons-attempt-month         ; reseted once a month
  g-houses-thefts-month           ; reseted once a month
  g-persons-thefts-month          ; reseted once a month
  g-avoided-thefts-month          ; reseted once a month
  cops-efficiency-day
  g-punishment-rate               ; updated daily
  g-risk-propensity-av
  g-frustration-av
]

patches-own [
  position_
  meaning
]

peoples-own [
  age-years
  age-months           ;; [1,12]
  age-days             ;; age in days
  social-class
  hourly-wage
  education-level
  my-firm
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  student?             ;; True, False
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home              ;; list with 2 address = pxcor,pycor
  vulnerability
  employed?
  my-wage
  victim?
  frustration-level
  risk-propensity
  sex
  marital

]

babies-own [
  age-years
  age-months
  age-days             ;; age in days
  social-class
  hourly-wage
  education-level
  my-firm
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  student?             ;; True, False
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home         ;; list with 2 address = pxcor,pycor
  vulnerability
  employed?
  my-wage
  victim?
  frustration-level
  risk-propensity
  sex
  marital
]

elderlies-own [
  age-years
  age-months
  age-days             ;; age in days
  social-class
  hourly-wage
  education-level
  my-firm
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  student?             ;; True, False
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home         ;; list with 2 address = pxcor,pycor
  vulnerability
  employed?
  my-wage
  victim?
  frustration-level
  risk-propensity
  sex
  marital
]

workers-own [
  age-years
  age-months
  age-days
  social-class
  hourly-wage
  education-level
  my-firm
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  student?             ;; True, False
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home         ;; list with 2 address = pxcor,pycor
  vulnerability
  employed?
  my-wage
  victim?
  frustration-level
  risk-propensity
  sex
  marital
]

unemployed_-own [
  age-years
  age-months
  age-days
  social-class
  education-level
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  thieve-just-act?
  thieve-time-inactive
  arrested?
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-firm
  my-home
  income
  vulnerability
  searching-job
  victim?
  frustration-level
  risk-propensity
  prison-sentence
  prison-time
  sex
  marital
  risk-propensity
  time-to-leave-home
  time-to-back-home
]

cops-own [
  age-years
  age-months
  age-days
  social-class
  my-home
  influence-radius
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  sex
  marital
  frustration-level
  risk-propensity
  education-level
  ]

students-own [
  age-years
  age-months
  age-days
  social-class
  work?
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  education-level
  initial-wealth
  wealth
  show-wealth?
  relative-wealth
  my-wealth
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home
  my-school
  vulnerability
  victim?
  frustration-level
  risk-propensity
  sex
  marital
]

thieves-own [
  age-years
  age-months
  age-days
  time-in-crime        ; in days acumulated
  social-class
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  my-home
  prison-address
  education-level
  thieve-just-act?
  thieve-time-inactive
  arrested?
  caught?
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-house-ptheft
  my-person-ptheft
  my-person-ptheft-suc
  prison-sentence
  prison-time
  searching-job
  frustration-level
  will-try-steal?
  risk-propensity
  cops-around-me
  risk-propensity
  sex
  marital
  time-to-leave-home
  time-to-back-home
]

prisoners-own [
  age-years
  age-months
  age-days
  time-in-crime
  education-level
  caught?
  my-home
  n-victims
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  penalty-time
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  social-class
  my-prison
  frustration-level
  risk-propensity
  sex
  marital
]

deads-own [
  age-years
  age-months
  age-days
  social-class
  hourly-wage
  education-level
  my-firm
  thieve-just-act?
  thieve-time-inactive
  arrested?
  prison-sentence
  prison-time
  student?             ;; True, False
  initial-wealth
  wealth
  my-wealth
  show-wealth?
  relative-wealth
  income
  was-just-stolen?
  times-stolen
  n-houses-thefts
  n-persons-thefts
  my-home              ;; list with 2 address = pxcor,pycor
  vulnerability
  employed?
  my-wage
  victim?
  frustration-level
  risk-propensity
  sex
  marital
]

houses-own [
  house-inhabitants
  meaning-class
  wealth
  was-just-stolen?
  times-stolen
  outlier-house?
  security-system
  house-ss
  dog
  electric-fence
  cooperative-vigilance
]

firms-own [
  firm-address
  initial-jobs
  current-jobs   ;; number of employees
  available-jobs ;; total labor demand of a firm
]

schools-own [
  school-address
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; SETUP TURTLES AND PATCHES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup
  clear-all
  random-seed seed
  set-default-shape turtles "person"
  set hour  0
  set day  1
  set month  1
  set year 1
  set yearCalendar 2021
  setup-patches
  setup-social-class
  update-time
  setup-buildings          ;; creates buildings - non animated turtles (schools, firms, prision)
  setup-population         ;; creates turtles (as people) and set ages, sex and marital
  setup-babies             ;; chages breed of some "peoples" to "babies"
  setup-students
  setup-elderlies
  setup-thieves            ;; do not move this. needs to be evoked before workers
  setup-prisoners          ;; do not move this. needs to be evoked before workers
  setup-workers            ;; chages breed of some "peoples" to "workers"
  setup-unemployed         ;; chages breed of some "workers" to "unemployed_"
  setup-cops               ;; changes turtles = "persons" to specific breeds and set respective variables
  setup-wealth-lifecost
  setup-firms-jobs         ;; needs to be computed after setup-workers
  setup-wage
  setup-education-level
; setup-income
; spread-population-in-houses
  houses-security

  ask turtles with [ shape = "person" and breed != cops and breed != babies] [
    set risk-propensity   random-float 0.7
  ]
  ask turtles with [ shape = "person" and breed = workers and breed = unemployed_ and breed = students ]
      [ set arrested? 0 set victim? 0 ]
  ask prisoners [ move-to my-prison ]
  setup-show-wealth
  update-gini-lorenz
  reset-ticks
end



to setup-patches
  resize-world ( ( ( grid-size - 1 ) / 2 ) * -1 ) ( ( grid-size - 1 ) / 2 )
               ( ( ( grid-size - 1 ) / 2 ) * -1 ) ( ( grid-size - 1 ) / 2 )
  set-patch-size ( population / (2 * grid-size) )
  let c0y ( ( ( grid-size - 1 ) / 2 ) * -1 )
  let c0x ( ( ( grid-size - 1 ) / 2 ) * -1 )
  let c1y c0y + grid-size / 5
  let c1x c0x + grid-size / 5
  diamond
  let interv-min min [ position_ ] of patches
  let interv max [ position_ ] of patches / 5
  let interv-max max [ position_ ] of patches / 5
  let yi 0
  let xi 0

  while [ xi <= 4 ] [
    ask patches with [ position_ >= interv-min and position_ <= interv-max ]
      [ set pcolor 0.9 + ( yi * 2 ) + ( xi * 2 ) ]
        set interv-min interv-min + interv
        set interv-max interv-max + interv
        set xi ( xi + 1 )
  ]
end

to diamond
  ask patches with [ pxcor <= 0 and pycor <= 0 ]
    [ set position_ ( pxcor * -1 ) + ( pycor * -1 ) ]
  ask patches with [ pxcor <= 0 and pycor > 0 ]
    [ set position_ ( pxcor * -1 ) + pycor ]
  ask patches with [ pxcor > 0 and pycor <= 0 ]
    [ set position_ pxcor + ( pycor * -1 )  ]
  ask patches with [ pxcor >= 0 and pycor >= 0 ]
    [ set position_ pxcor + pycor ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Differentiate patches by social class
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-social-class
  ask patches with [ pcolor = 0.9 ] [ set meaning "A" ]
  ask patches with [ pcolor = 2.9 ] [ set meaning "B" ]
  ask patches with [ pcolor = 4.9 ] [ set meaning "C" ]
  ask patches with [ pcolor = 6.9 ] [ set meaning "D" ]
  ask patches with [ pcolor = 8.9 ] [ set meaning "E" ]
  if show-class? = false [ ask patches [ set pcolor black ] ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Setup-turtles1 set building and houses, or lifeless turtles
;;  Everything is created as turtles, even houses, factory, school, prision. A house and others are an agent!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-buildings                                  ;; a pnad marca uma média de 3 habitantes por casa na média. Poderia trocar para 0,33 ao invés de 0,5?
  create-houses (0.33 * population) [               ;; each house has two inhabitants on average. After agents be distributed may exist houses with more inhabitants
    set shape "house-patch"                         ;; empty houses will be deleted after setting population in houses
    set color white
    set was-just-stolen? 0
    setxy random-xcor random-ycor
    ask houses [
      if any? other houses in-radius 3 [ move-to one-of patches with [ count houses in-radius 2 = 0 ]  ]  ;; redistributing piled houses
      if meaning = "A" [ set meaning-class "A" ]    ;; seting social class of each house
      if meaning = "B" [ set meaning-class "B" ]
      if meaning = "C" [ set meaning-class "C" ]
      if meaning = "D" [ set meaning-class "D" ]
      if meaning = "E" [ set meaning-class "E" ]
    ]
  ]

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  Create firms, schools and prisions
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; São criadas n-firmas. O objetivo aqui, criando diferentes firmas é
  ;; que alguma delas pode demitir pessoas que estejam empregadas (dificuldade financeira, por exemplo).
  create-firms num-firms [
    set shape "factory"
    set color green
    set size 5
    setxy random-pxcor random-pycor
  ]

  create-schools 1 [
    set shape "house ranch"
    set color blue
    set size 7
    setxy random-xcor random-ycor
  ]

  create-prisons 1 [
    set shape "building institution"
    set size 5
    set color 27
    setxy random-xcor random-ycor
  ]
end

to setup-population
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Create whole population as generic turtles and set ages
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  create-peoples population [
    set shape "person"
    set size 3
    set color white - 3
    let tmp 0
    ifelse random-float 1 > 0.48 [ set tmp 0 ] [ set tmp 1 ]     ; 0=female  1=male        ;;Distribuição da população de Curitiba por gênero (PNAD 2009 e Censo 2010)
    set sex tmp
    ifelse random-float 1 > 0.45 [ set tmp 0 ] [ set tmp 1 ]     ; 0=single  1=married     ;;Distribuição da população de Curitiba por estado civil (PNAD 2009)
    set marital tmp
    set thieve-time-inactive random 37
  ]
  setup-population-age
  setup-population-houses
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SETTING AGES
;; Ages percents replicate statistics of Curitiba/PR (Censo 2010 - IBGE. Disponível em: https://censo2010.ibge.gov.br/sinopse/webservice/frm_piramide.php?codigo=410690&corhomem=3d4590&cormulher=9cdbfc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-population-age
  ask turtles with [ shape = "person" ] [
    let age-dist random 100
    if age-dist <= 6.2                      [ set age-years 0  + random 5 set age-months random 12 ]
    if age-dist > 6.2  and age-dist <= 12.6 [ set age-years 5  + random 5 set age-months random 12 ]
    if age-dist > 12.6 and age-dist <= 20.0 [ set age-years 10 + random 5 set age-months random 12 ]
    if age-dist > 20.0 and age-dist <= 27.9 [ set age-years 15 + random 5 set age-months random 12 ]
    if age-dist > 27.9 and age-dist <= 37.0 [ set age-years 20 + random 5 set age-months random 12 ]
    if age-dist > 37.0 and age-dist <= 46.5 [ set age-years 25 + random 5 set age-months random 12 ]
    if age-dist > 46.5 and age-dist <= 55.3 [ set age-years 30 + random 5 set age-months random 12 ]
    if age-dist > 55.3 and age-dist <= 63.2 [ set age-years 35 + random 5 set age-months random 12 ]
    if age-dist > 63.2 and age-dist <= 70.6 [ set age-years 40 + random 5 set age-months random 12 ]
    if age-dist > 70.6 and age-dist <= 77.6 [ set age-years 45 + random 5 set age-months random 12 ]
    if age-dist > 77.6 and age-dist <= 83.6 [ set age-years 50 + random 5 set age-months random 12 ]
    if age-dist > 83.6 and age-dist <= 88.7 [ set age-years 55 + random 5 set age-months random 12 ]
    if age-dist > 88.7 and age-dist <= 92.4 [ set age-years 60 + random 5 set age-months random 12 ]
    if age-dist > 92.4 and age-dist <= 95.1 [ set age-years 65 + random 5 set age-months random 12 ]
    if age-dist > 95.1 and age-dist <= 97.0 [ set age-years 70 + random 5 set age-months random 12 ]
    if age-dist > 97.0 and age-dist <= 98.4 [ set age-years 75 + random 5 set age-months random 12 ]
    if age-dist > 98.4 and age-dist <= 99.4 [ set age-years 80 + random 5 set age-months random 12 ]
    if age-dist > 99.4 and age-dist <= 99.8 [ set age-years 85 + random 5 set age-months random 12 ]
    if age-dist > 99.8 and age-dist <= 100  [ set age-years 90 + random 5 set age-months random 12 ]
    set age-days age-years * 360 + age-months * 30 + 1 + random 30
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup population houses
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Every one has a house. A house can have 3 people at the most. Babies and students do not live alone          ;;;Se mudar a média de habitantes, mudar o máximo aqui também
to setup-population-houses
  ask peoples with [ age-years >= 25 ] [                            ;; arbitrary, only people older than 25 can originaly have a house
    let chosed-house one-of houses
    set my-home chosed-house
    move-to my-home
  ]
  ask houses [ set house-inhabitants count turtles-here with [ shape = "person" ] ]
  ask houses with [ house-inhabitants = 0 ] [ die ]                ;; delete empty houses
  ask peoples with [ age-years < 25 ] [                            ;; Babies and young people will live with adults above 25 years
    let home-chosed one-of houses with [ house-inhabitants <= 5 ]               ;;; novo maximo de habitantes = 5
    set my-home home-chosed
    move-to my-home
  ]
  ask houses [ set house-inhabitants count turtles-here with [ shape = "person" ] ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup babies
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This need to be improved by taking into account real statistics of babies as percentge of population
to setup-babies
  ask peoples with [age-years <= 6 ] [              ;;; já tá com a distribuição da faixa etária aqui?
    set breed babies
    set color pink
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup students
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This need to be improved by taking into account real statistics of students as percentge of population
to setup-students
  ask peoples with [ age-years > 6 and age-years < 18 ] [           ;;já está com a distribuição de estudantes aqui?
    set breed students
    set color magenta
    set my-school one-of schools
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup elderlies
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-elderlies
  ask peoples with [age-years > 75 ] [
    set breed elderlies
    set color brown
  ]
end

to setup-thieves
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Thieves - this need to be computed before Workers and others because the stock of
  ;; peoples available to designate. Thives are confined to a specific age (Shikida, 2020). Disponível em: http://rbepdepen.depen.gov.br/index.php/RBEP/article/view/45
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  let num-thieves-create population * ( perc-of-thieves )
  ask n-of (0.06 * num-thieves-create) peoples with [ age-years >= 15 and age-years <= 18 ] [ setup-thieves-aux  ]
  ask n-of (0.28 * num-thieves-create) peoples with [ age-years >= 19 and age-years <= 23 ] [ setup-thieves-aux  ]
  ask n-of (0.21 * num-thieves-create) peoples with [ age-years >= 24 and age-years <= 28 ] [ setup-thieves-aux  ]
  ask n-of (0.16 * num-thieves-create) peoples with [ age-years >= 29 and age-years <= 33 ] [ setup-thieves-aux  ]
  ask n-of (0.10 * num-thieves-create) peoples with [ age-years >= 34 and age-years <= 38 ] [ setup-thieves-aux  ]
  ask n-of (0.06 * num-thieves-create) peoples with [ age-years >= 39 and age-years <= 43 ] [ setup-thieves-aux  ]
  ask n-of (0.05 * num-thieves-create) peoples with [ age-years >= 44 and age-years <= 48 ] [ setup-thieves-aux  ]
  ask n-of (0.07 * num-thieves-create) peoples with [ age-years >= 49 ] [ setup-thieves-aux  ]
end
to setup-thieves-aux
    set breed thieves
    set color yellow
    setxy random-xcor random-ycor
    set searching-job precision random-float 0.75 5
    set caught? false                             ;; inicialmente, todos os infratores recebem a sinalização de que não foram pegos pelos policiais.
    set will-try-steal? false                     ;; inicialmente, todos os infratores recebem a sinalização de que não vão tentar roubar.
    set prison-sentence 0                         ;; sentença de prisão inicial para cada infrator.
    set time-in-crime random 60                   ;; at the begining consider he has lived random 360 days in the crime's world in the past
    set risk-propensity random-float 0.7
    set thieve-time-inactive random time-inactive
end


to setup-prisoners
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Prisoners
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; incarceration rate of Paraná (Shikida, 2020). Disponível em: http://rbepdepen.depen.gov.br/index.php/RBEP/article/view/45
  let num-prisoners-create (population * incarceration-tax)
  ask n-of (0.06 * num-prisoners-create) peoples with [ age-years = 18 ] [ setup-prisoners-aux  ]
  ask n-of (0.28 * num-prisoners-create) peoples with [ age-years >= 19 and age-years <= 23 ] [ setup-prisoners-aux  ]
  ask n-of (0.21 * num-prisoners-create) peoples with [ age-years >= 24 and age-years <= 28 ] [ setup-prisoners-aux  ]
  ask n-of (0.16 * num-prisoners-create) peoples with [ age-years >= 29 and age-years <= 33 ] [ setup-prisoners-aux  ]
  ask n-of (0.10 * num-prisoners-create) peoples with [ age-years >= 34 and age-years <= 38 ] [ setup-prisoners-aux  ]
  ask n-of (0.06 * num-prisoners-create) peoples with [ age-years >= 39 and age-years <= 43 ] [ setup-prisoners-aux  ]
  ask n-of (0.05 * num-prisoners-create) peoples with [ age-years >= 44 and age-years <= 48 ] [ setup-prisoners-aux  ]
  ask n-of (0.07 * num-prisoners-create) peoples with [ age-years >= 49 ] [ setup-prisoners-aux  ]
end
to setup-prisoners-aux
  set breed prisoners
  set color white
  set arrested? true
  set my-prison one-of prisons
  set prison-sentence 48 + random max-prison-sentence
  set risk-propensity random-float 0.7
  set time-in-crime random 60                   ;; consider he has lived 30 days in the crime's world in the past
  move-to my-prison
end


to setup-workers
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Workers
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask peoples with [ age-years >= 15 and age-years <= 75 ] [            ;;; a idade economicamente ativa começa aos 15 e não aos 18
    set breed workers
    set color green
    setxy random-xcor random-ycor
    set my-firm one-of firms         ;; set the worker's firm
    set employed? true               ;; the worker has a job currently
    move-to my-home                  ;; after create a worker move she to her house
  ]
end

to setup-unemployed
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Unemployed
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  let num-workers count workers
  ask n-of ( num-workers * p-unemployment-rate ) workers [
    set breed unemployed_
    set color orange
;   setxy round ( random-xcor ) round ( random-ycor )
    move-to my-home
  ]
  let tmp-n-unemployed count unemployed_
  let tmp-list-of-actives n-of ( precision (tmp-n-unemployed - initial-discouraged * tmp-n-unemployed) 0 ) unemployed_
  ask tmp-list-of-actives [                    ;; active unemployed are workers searching for job by 6 months at least.
    set color red
    set searching-job 0.1 + random-float 0.5
  ]
  let tmp-list-of-discoureged unemployed_ with [ not member? self tmp-list-of-actives ]
  ask tmp-list-of-discoureged [                     ;; discouraged unemployed are workers searching for job by more than 6 months.
    set color red
    set searching-job ( 0.5 + random-float 0.4 )
  ]
  set unemployment-rate count unemployed_ / count turtles with [shape = "person" and age-years >= 15 and age-years < 75 ]
end

to setup-cops
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Polices
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask n-of (num-of-cops * population) workers [              ;;; 0,026 * population @ the interface. This can be modified to analyze the impact of more cops on crimes
    set breed cops
    set color blue
    setxy random-xcor random-ycor
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Initial updating of workers by firms and capacity utilization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This procedure needs to be runned after creating population and workers
to setup-firms-jobs
  ask firms [
    let firm-who who                 ;; return a number
    let current-firm firm firm-who   ;; return an agentset with one element/firm
    set current-jobs count workers with [ my-firm = current-firm ]
  ]
  let n-firms   count firms
  let n-workers count workers
  let workers-by-firm (precision (1.2 * ( n-workers / n-firms )) 0) - 1   ;; Initial labor demand is 20% higher than labor supply. Firms start with 80% of capacity utilization
  ask firms [
    set available-jobs workers-by-firm
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFININDO RIQUEZA (DESIGUALDADE) E CUSTO DE VIDA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-wealth-lifecost      ;; VER LIFECOST     ;;; DIEESE 2010 - Custo da cesta básica em Curitiba equivalia a 52% do Salário Mínimo. disponível em: https://www.dieese.org.br/analisecestabasica/2010/201012cestabasica.pdf
  ask patches [
    if meaning = "E" [
      ask turtles-here with [ shape = "person" ] [
        let rn random-normal 0 1
        let mi ( ln ( p-average-wealth ) - ( ( phi ^ 2 ) / 2 ) )
        set wealth ( e ^ ( mi + ( phi * rn ) ) )
        set initial-wealth wealth
        set my-wealth wealth
        set social-class "E"
      ]
    ]
    if meaning = "D" [
      ask turtles-here with [ shape = "person" ] [
        let rn random-normal 0 1
        let mi ( ln ( sum-media + p-average-wealth ) - ( (  phi ^ 2 ) / 2 ) )
        set wealth ( e ^ ( mi + ( phi * rn ) ) )
        set initial-wealth wealth
        set my-wealth wealth
        set social-class "D"
      ]
    ]

    if meaning = "C" [
      ask turtles-here with [ shape = "person" ] [
        let rn random-normal 0 1
        let mi ( ln ( 4 * sum-media + p-average-wealth ) - ( ( phi ^ 2 ) / 2 ) )
        set wealth ( e ^ ( mi + ( phi * rn ) ) )
        set initial-wealth wealth
        set my-wealth wealth
        set social-class "C"
      ]
    ]

    if meaning = "B" [
      ask turtles-here with [ shape = "person" ] [
        let rn random-normal 0 1
        let mi ( ln ( 15 * sum-media + p-average-wealth ) - ( ( phi ^ 2 ) / 2 ) )
        set wealth ( e ^ ( mi + ( phi * rn ) ) )
        set initial-wealth wealth
        set my-wealth wealth
        set social-class "B"
      ]
    ]

    if meaning = "A" [
      ask turtles-here with [ shape = "person" ] [
        let rn random-normal 0 1
        let mi ( ln ( 30 * sum-media + p-average-wealth ) - ( ( phi ^ 2 ) / 2 ) )
        set wealth ( e ^ ( mi + ( phi * rn ) ) )
        set initial-wealth wealth
        set my-wealth wealth
        set social-class "A"
      ]
    ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  DEFININDO SALÁRIOS DOS TRABALHADORES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hourly wage according to social class in Brazil, considering a 40h work-week (160h work-month) and minimun wage-month of R$ 510 (2010)
to setup-wage
  ask workers with [ social-class = "E" ] [ set hourly-wage random 6.37  ]                   ;; hourly wage of class E (up to 2 minimum wages) = 6,37
  ask workers with [ social-class = "D" ] [ set hourly-wage 6.38 + random-float 12.75 ]      ;; hourly wage of class D (between 2 and 4 minimum wages) = 6,38 up tp 12,75
  ask workers with [ social-class = "C" ] [ set hourly-wage 12.76 + random-float 31.87 ]     ;; hourly wage of class C (between 4 and 10 minimum wages)= 12,76 up tp 31,87
  ask workers with [ social-class = "B" ] [ set hourly-wage 31.88 + random-float 63.75 ]     ;; hourly wage of class B (between 10 and 20 minimum wages)= 31,88 up tp 63,75
  ask workers with [ social-class = "A" ] [ set hourly-wage 63.76 + random-float 159.37 ]    ;; hourly wage of class A (between 20 and 50 minimum wages)= 63,76 up to 159,97
  ask workers [ set my-wage hourly-wage ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFININDO OS ANOS DE EDUCAÇÃO PARA ESTUDANTES DE DETERMINADA IDADE E CLASSE SOCIAL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup-education-level
  ask students [
    if social-class = "A" [
    if age-years < 18 [ set education-level random-float (10 + random-float 1) ]            ;; o objetivo aqui foi colocar uma quantidade específica de anos de educação para um
    if age-years < 15 [ set education-level random-float (7 + random-float 1) ]             ;; estudante já matriculado. Por exemplo, uma pessoa de 17 anos da classe A terá pelo
    if age-years < 12 [ set education-level random-float (4 + random-float 1) ]             ;; menos 9 anos de educação acumulados. É bastante difícil achar números reais nesse caso
    if age-years <  9 [ set education-level random-float (2 + random-float 0) ]             ;; (anos de educação por classe social) mesmo para países desenvolvidos, como os EUA.
    if age-years <  7 [ set education-level 0 ]
    ]

    if social-class = "B" [
    if age-years < 18 [ set education-level random-float (8 + random-float 3) ]
    if age-years < 15 [ set education-level random-float (5 + random-float 3) ]
    if age-years < 12 [ set education-level random-float (3 + random-float 2) ]
    if age-years <  9 [ set education-level random-float (2 + random-float 0) ]
    if age-years <  7 [ set education-level 0 ]
    ]

    if social-class = "C" [
    if age-years < 18 [ set education-level random-float (6 + random-float 5) ]
    if age-years < 15 [ set education-level random-float (4 + random-float 4) ]
    if age-years < 12 [ set education-level random-float (2 + random-float 3) ]
    if age-years <  9 [ set education-level random-float (2 + random-float 0) ]
    if age-years <  7 [ set education-level 0 ]
    ]

    if social-class = "D" [
    if age-years < 18 [ set education-level random-float (5 + random-float 6) ]
    if age-years < 15 [ set education-level random-float (3 + random-float 5) ]
    if age-years < 12 [ set education-level random-float (1 + random-float 4) ]
    if age-years <  9 [ set education-level random-float (1 + random-float 1) ]
    if age-years <  7 [ set education-level 0 ]
    ]

    if social-class = "E" [
    if age-years < 18 [ set education-level random-float (9 + random-float 2) ]
    if age-years < 15 [ set education-level random-float (6 + random-float 2) ]
    if age-years < 12 [ set education-level random-float (4 + random-float 1) ]
    if age-years <  9 [ set education-level random-float (1 + random-float 1) ]
    if age-years <  7 [ set education-level 0 ]
    ]
  ]
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;   DEFININDO OS ANOS DE EDUCAÇÃO PARA TRABALHADORES E DESEMPREGADOS
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; o objetivo aqui, assim como realizado para estudantes, foi o de definir um determinado nível de educação para
  ;; os adultos (pessoas que já passaram pela escola num período "pré-setup"). Pessoas de classe mais alta possuem
  ;; um desvio menor para os anos de educação (necessariamente 14 anos + um número aleatório de até 3).
  ;;
  ;; tentei deixar o código mais limpo com o comando "ask turtles with [ breed = workers and breed = unemployed_]
  ;; porém, como o comando não funcionou, tive que escrever duas vezes
  ;; (uma para desempregados e outra para trabalhadores).
  ask workers [
    if social-class = "A" [ set education-level ( 14 + random-float 3 ) ]
    if social-class = "B" [ set education-level ( 11 + random-float 5 ) ]
    if social-class = "C" [ set education-level ( 8 + random-float 7 )  ]
    if social-class = "D" [ set education-level ( 5 + random-float 8 ) ]
    if social-class = "E" [ set education-level ( 2 + random-float 9 ) ]
  ]

  ask unemployed_ [
    if social-class = "A" [ set education-level ( 14 + random-float 3 ) ]
    if social-class = "B" [ set education-level ( 11 + random-float 5 ) ]
    if social-class = "C" [ set education-level ( 8 + random-float 7 )  ]
    if social-class = "D" [ set education-level ( 5 + random-float 8 ) ]
    if social-class = "E" [ set education-level ( 2 + random-float 9 ) ]
  ]

  ask thieves [
    if social-class = "A" [ set education-level ( 10 + random-float 3 ) ]
    if social-class = "B" [ set education-level ( 8 + random-float 5 ) ]
    if social-class = "C" [ set education-level ( 6 + random-float 7 )  ]
    if social-class = "D" [ set education-level ( 4 + random-float 8 ) ]
    if social-class = "E" [ set education-level ( 2 + random-float 9 ) ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting up houses' security system
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to houses-security
  ask houses with [ meaning-class = "A" ] [
    let av-wealth-A ( sum [ wealth ] of other turtles-here with [ shape = "person" ] / house-inhabitants )
    let total-av-wealth-A ( sum [ wealth ] of turtles with [ shape = "person" and social-class = "A" ] / count turtles with [ shape = "person" and social-class = "A" ] )
    ifelse av-wealth-A > total-av-wealth-A [ set outlier-house? true ] [ set outlier-house? false ]
    ifelse outlier-house? = true [ if random 100 < 90 [ set security-system true set house-ss (0.5 + random-float 0.3) ] ]
                                 [ if random 100 < 70 [ set security-system true set house-ss (0.4 + random-float 0.3) ] ]
  ]

  ask houses with [ meaning-class = "B" ] [
    let av-wealth-B ( sum [ wealth ] of other turtles-here with [ shape = "person" ] / house-inhabitants )
    let total-av-wealth-B ( sum [ wealth ] of turtles with [ shape = "person" and social-class = "B" ] / count turtles with [ shape = "person" and social-class = "B" ] )
    ifelse av-wealth-B > total-av-wealth-B [ set outlier-house? true ] [ set outlier-house? false ]
    ifelse outlier-house? = true [ if random 100 < 70 [ set security-system true set house-ss (0.4 + random-float 0.2) ] ] ;; se as pessoas de determinada casa tiverem
                                 [ if random 100 < 50 [ set security-system true set house-ss (0.3 + random-float 0.2) ] ] ;; renda média acima da renda média de sua
  ]                                                                                                                                  ;; classe social, existe maior probabilidade.

  ask houses with [ meaning-class = "C" ] [
    let av-wealth-C ( sum [ wealth ] of other turtles-here with [ shape = "person" ] / house-inhabitants )
    let total-av-wealth-C ( sum [ wealth ] of turtles with [ shape = "person" and social-class = "C" ] / count turtles with [ shape = "person" and social-class = "C" ] )
    ifelse av-wealth-C > total-av-wealth-C [ set outlier-house? true ] [ set outlier-house? false ]
    ifelse outlier-house? = true [ if random 100 < 60 [ set security-system true set house-ss (0.3 + random-float 0.2) ] ]
                                 [ if random 100 < 40 [ set security-system true set house-ss (0.3 + random-float 0.2) ] ]

  ]

  ask houses with [ meaning-class = "D" ] [
    let av-wealth-D ( sum [ wealth ] of other turtles-here with [ shape = "person" ] / house-inhabitants )
    let total-av-wealth-D ( sum [ wealth ] of turtles with [ shape = "person" and social-class = "D" ] / count turtles with [ shape = "person" and social-class = "D" ] )
    ifelse av-wealth-D > total-av-wealth-D [ set outlier-house? true ] [ set outlier-house? false ]
    ifelse outlier-house? = true [ if random 100 < 50 [ set security-system true set house-ss (0.2 + random-float 0.2) ] ]
                                 [ if random 100 < 30 [ set security-system true set house-ss (0.1 + random-float 0.2) ] ]
  ]

  ask houses with [ meaning-class = "E" ] [
    let av-wealth-E ( sum [ wealth ] of other turtles-here with [ shape = "person" ] / house-inhabitants )
    let total-av-wealth-E ( sum [ wealth ] of turtles with [ shape = "person" and social-class = "E" ] / count turtles with [ shape = "person" and social-class = "E" ] )
    ifelse av-wealth-E > total-av-wealth-E  [ set outlier-house? true ] [ set outlier-house? false ]
    ifelse outlier-house? = true [ if random 100 < 40 [ set security-system true set house-ss (0.1 + random-float 0.2) ] ]
                                 [ if random 100 < 20 [ set security-system true set house-ss (0.0 + random-float 0.2) ] ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINING WHETHER PEOPLE SHOW THEIR WEALTH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; People who show some portion of their wealth have a higher probability to be stolen
;; (see inequality and visibility - Hicks & Hicks, 2014).
to setup-show-wealth
  ask turtles with [ shape = "person" ][
  ifelse prob-show-wealth > random-float 1 [ set show-wealth? true ] [ set show-wealth? false ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SPREADING POPULATION AND DELETING EMPTY HOUSES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; We assume max = 5 inhabitants by house. This can be improved by using real statistics about number of people by house.
;; This subroutine needs to runned only after create all breeds and have been designated a house for them.
to spread-population-in-houses
  ask peoples [
    let empty-houses houses with [ count other turtles-here < 5 ]                     ;;; assumir max = 5 habitantes
    if ( count other turtles-here >= 5 ) [ move-to one-of empty-houses ]
  ]
end

to spread-population-old
  ask turtles with [ shape = "person" ] [
    let empty-houses houses with [ count other turtles-here < 5 ]                     ;;; assumir max = 5 habitantes
    if ( count other turtles-here >= 5 ) [ move-to one-of empty-houses ]
    ]
end

to delete-empty-houses
  ask houses [
    if not any? other turtles-here [ die ]
  ]
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MODEL'S DYNAMICS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go
  update-time
  update-turtles-age
  if hour = 0 [                               ;; reset some variables once a day
    okun-update
    set g-houses-attempt-day 0
    set g-persons-attempt-day 0
    set g-houses-thefts-day 0
    set g-persons-thefts-day 0
    set g-avoided-thefts-day 0
    set g-avoided-house-day 0
    set g-avoided-person-day 0
    ask houses [ set color gray ]
    if gini? = true [ update-gini-lorenz ]
    update-thieves
    update-prisoners
    update-stud-job
    became-a-thieve
  ]
  if (hour = 0 and day = 1) [                 ;; reset some variables once a month and firms hire workers on 1st day
    set g-houses-attempt-month 0
    set g-persons-attempt-month 0
    set g-houses-thefts-month 0
    set g-persons-thefts-month 0
    set g-avoided-thefts-month 0
    ask turtles with [ shape = "person"] [set n-houses-thefts 0 ]
    distribute-jobs2                          ;; firms adjust labor once a month
    person-reproduce                          ;; population reproduce
    person-die                                ;; population die
  ]
  go-back-work
  go-back-school
  move-unemployed_
  move-thieves
  move-cops

  ;; chose a house or person,  try to stole and get results: 1.) successful, 2.) killed, 3.) arrested
  let tmp-dummy random 2
  ifelse tmp-dummy = 0 [try-stole-house ][try-stole-person ]

  if hour = 23 [
    update-cops-efficiency-day
    update-frustration
    update-risk-propensity
    update-punishment-rate
  ]
  if ticks = 8640 [ stop ]
  tick         ;; one tick = 1 hour
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TRABALHADOR SE DESLOCANDO ENTRE CASA E TRABALHO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go-back-work
  if ( hour = 6 ) [
    ask workers  [
      set hidden? true
      set vulnerability 1 ]                               ;; workers leave home and become susceptible to be stolen on the way to firms
  ]
  if ( hour = 8 )[                                        ;; move workers to firm and become not susceptible
    ask workers [
      move-to my-firm
      set hidden? false
      set vulnerability 0
      set income income + 8 * hourly-wage                  ;; increase wage-daily
      set wealth wealth + income - life-cost
    ]
  ]
  if hour = 17 [
    ask workers [ set hidden? true set vulnerability 1 ]   ;; workers leave firms and became susceptible to be stolen on the way back home
  ]
  if hour = 18 [                                           ;; move workers to home
    ask workers [
      move-to my-home
      set hidden? false
      set vulnerability 0
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ESTUDANTES SE DESLOCANDO ENTRE CASA E ESCOLA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go-back-school
  if ( hour = 6 ) [
    ask students [
      set hidden? true
      set vulnerability 1
      set education-level education-level + (1 / (360))    ;; students leave home and become susceptible to be stolen on the way to school
    ]
  ]
  if ( hour = 7 )[                                              ;; move students to school and become not susceptible
    ask students [
      move-to my-school                                         ;; students are 7 to 18 years old and someone may leave school to start working
      set hidden? false
      set vulnerability 0
    ]
  ]
  if hour = 13 [
    ask students [ set hidden? true set vulnerability 1 ]       ;; students leave school and become susceptible to be stolen on the way back home
  ]
  if hour = 14 [                                                ;; arrive at home
    ask students [
     move-to my-home
     set hidden? false
     set vulnerability 0
   ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MOVIMENTANDO DESEMPREGADOS ATIVOS E DESALENTADOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to move-unemployed_
  ask unemployed_ [
    set searching-job searching-job + (1 / (360 * 24))     ;; atualizar tempo desempregado continuamente.
    if searching-job <= 0.5 [                              ;; se estiver procurando emprego há menos de seis meses, trata-se de um desempregado ativo.
      ifelse ( hour >= 6 and hour <= 18 )                  ;; o horário de deslocamento dos desempregados ativos é o mesmo dos trabalhadores (horário comercial para buscar emprego).
        [ right random 180
          fd 2
          set vulnerability 1 ]
        [ move-to my-home
          set vulnerability 0 ]
    ]
    if searching-job > 0.5 [                               ;; se estiver procurando emprego há mais de seis meses, trata-se de um desempregado desalentado (desistiu de procurar).
      ifelse ( hour >= random 24 and hour <= random 24 )   ;; nesse caso, diferente dos desempregados ativos (que procuram emprego em horário comercial), os desempregados
       [ right random 180                                  ;; desalentados podem sair de casa em qualquer horário (fazer algum bico ou entrar em contado com criminosos
          fd 2                                             ;; para saber quanto conseguiriam lucrar em atividades ilegítimas (já que as atividades legítimas não estão disponíveis).
          set vulnerability 1 ]
       [ move-to my-home                                   ;; os dados de desempregados desencorajados podem ser encontrados em:
          set vulnerability 0 ]                            ;; https://www.thebalance.com/discouraged-workers-definition-causes-and-effects-3305514.
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVIMENTANDO LADRÕES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to move-thieves
  ask thieves [
    if hour = 0 [                                 ;; thives once a day decide randomly how much time to spend out, walking around
      set time-to-leave-home random 7
      set time-to-back-home  7 + random 17
    ]
    if hour = time-to-leave-home [
      right random 360
      fd min-stole-radius + random stole-radius
    ]
    ifelse ( hour >= time-to-leave-home and hour <= time-to-back-home )   ;; thieves leaves home and stay walking around during a random elapsed time - updated once a day
    [ right random 360
      fd 5 + random 5
    ]
    [ move-to my-home ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESTRATÉGIA DE POLICIAMENTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a estratégia de policiamento hot-spot seguirá essa lógica, mas precisa ser aprimorada.
to move-cops
  ask cops [
    ifelse random-patrol? = true                        ;; o switch define se a estratégia de policiamento será ou não aleatória.
    [ right random 180 fd 2 ]
    [ ask n-of (count cops * 0.3) cops [ move-to one-of patches with [ meaning = "E" ] ] ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  UPDATE-TIME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to update-time
  set hour hour + 1
  if hour = 24  [ set day day + 1 set hour 0 ]      ;; update day
  if day = 31   [
    set month month + 1
    set day 1
  ]
  if month = 13 [
    set month 1
    set year year + 1                               ;; update year
    set yearCalendar yearCalendar + 1
  ]
  if Clock? [set clock (word day "/" month "/"  yearCalendar ":" hour) ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updating Ages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to update-turtles-age
  if hour = 0 [
    ask turtles with [shape = "person" and breed != "deads" ][
      let tmp-my-home my-home
      set age-days age-days + 1
      set age-years  int (age-days / 360)
      set age-months int ( ((age-days / 360) - age-years) * 30  )
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reproduce turtles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; all population reproduce once a month
to person-reproduce
  let n-babies-create precision ( ((1 + pop-natality-rate)^(1 / 12) - 1) * population ) 0
  if n-babies-create = 0 [ stop ]
  repeat n-babies-create [
    let tmp-my-home ""
    let tmp-social-class ""
    ask one-of houses with [ house-inhabitants < 5 ] [          ;Se tiver menos que 5 pessoas, o bebê nasce nessa casa.
      set tmp-my-home turtle who
      set tmp-social-class meaning-class
      set house-inhabitants house-inhabitants + 1
    ]
    create-babies 1 [
      set color pink
      set size 3
      set age-years 0
      set age-months 0
      set age-days 1
      set my-home tmp-my-home
      set social-class tmp-social-class
      set my-wealth 0
      move-to my-home
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Die Turtles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; all population is tested to die once a month
to person-die
  let n-person-die precision ( ((1 + pop-mortality-rate)^(1 / 12) - 1) * population ) 0
  if n-person-die = 0 [ stop ]
  let i 1
  while [i <= n-person-die] [
;   user-message (word "n-person-die: " n-person-die)
    ask one-of turtles with [ shape = "person" ][
      let tmp-prob-die 1 / ( 1 + exp(-(age-days - 18000) / 3000) )
      if tmp-prob-die > random-float 1 [
        set breed deads                              ;; turtle not properly die but is changed to deads breed
        set color brown
        let tmp-my-home my-home
        ask tmp-my-home [ set house-inhabitants house-inhabitants - 1 ]
        set i i + 1
      ]
    ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updating studentd jobs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to update-stud-job
  ask students [
    if age-years >= 18  [
      ifelse education-level > required-education       ;; se o estudante atinge 18 anos e seu nível educacional não é o mínimo solicitado pelo mercado, estes se tornam desempregados.
      [ set breed workers
        set color green
        set size 3
        set my-firm one-of firms
        set my-home one-of houses
      ]
      [
        set breed unemployed_                           ;; como fazer os agentes seguirem todos as regras do novo breed sem precisar escrever de novo?
        set color orange
        set size 3
      ]
    ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Houses Thefts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make decision in three steps: 1.) Chose a house; 2.) Evaluate circunstance; 3.) Try to stole
;; When trying to stole three results can happen: 1.) successful, 2.) killed, 3.) arrested
;; House Theft should be a function of = f[ Social Risk, Cops around,  house security, ... ??]
to try-stole-house
  ask thieves [
    set thieve-time-inactive thieve-time-inactive + 1      ; time-inactive is 36hour at minimum. If time is higher than 36+Unif(240)
    if thieve-time-inactive < time-inactive  [ stop ]      ; he/she became active and variable is reset to zero!
    ;1. Choose a house
    set will-try-steal? false
    if hour = 0 [ set time-in-crime time-in-crime + 1 ]     ; compute this only here, not in try-stole-person, to avoid duplicating
    let tmp-house-ss 0
    let tmp-house-chosen ""
    let n-houses count houses in-radius stole-radius
    ifelse n-houses > 0 [
      ask one-of houses in-radius stole-radius [
        set tmp-house-chosen who
        set tmp-house-ss house-ss
      ]
    ]
    [ stop ]
    ;2. The thieve evaluate the circunstances: police around and house's security system and make decision
    let tmp-cops-distance 99
    if any? cops in-radius cops-radius [
       set tmp-cops-distance distance (min-one-of cops in-radius cops-radius [distance myself])
    ]
    let tmp-prob-cops 1 / (1 + exp( -(tmp-cops-distance - 5) / 1) )           ; see calibration in ModCrime2021-01.R (increasing function)
    let tmp-prob-ss   1 / (1 + exp( -(tmp-house-ss - 0.3) / 0.1) )             ; see calibration in ModCrime2021-01.R (decreasing function)
    let tmp-prob-to-stole (risk-propensity + tmp-prob-cops + tmp-prob-ss) / 3  ; 0 <= all probs <= 1 Average with equal weight

   ;user-message (word "prob-to-stole: " tmp-prob-to-stole  "; risk-propensity: " risk-propensity   "; prob-cops: " tmp-prob-cops  "; prob-ss: " tmp-prob-ss )


    if tmp-prob-to-stole > 0.90 [
      set will-try-steal? true
      set thieve-time-inactive 0
      set g-houses-attempt-day   g-houses-attempt-day + 1
      set g-houses-attempt-month g-houses-attempt-month + 1
    ]

    ;3. Stole in action, evaluate the result: a.) successfull, b.) killed in action, c.) arrested
    if will-try-steal? [
      let tmp-prob-time   0.8 / ( 1 + exp( -(time-in-crime - 20) / 7) )
      let tmp-prob-stole-house (tmp-prob-time + tmp-prob-cops + tmp-prob-ss) / 3    ; success is about 80 to 95% of the cases
;     user-message (word "prob-to-stole-house: " tmp-prob-stole-house " = " tmp-prob-time " : " tmp-prob-cops " : " tmp-prob-ss )
      if tmp-prob-stole-house <= 0.4  [                                     ; if not successful with very low prob, then die
        set breed deads
          set color brown
          set g-avoided-house-day    g-avoided-house-day + 1
          set g-avoided-thefts-day   g-avoided-thefts-day + 1
          set g-avoided-thefts-month g-avoided-thefts-month + 1
          set viol-deaths viol-deaths + 1
      ]
      if tmp-prob-stole-house > 0.4 and tmp-prob-stole-house <= 0.7 [        ; if not successful with not so low prob, then arrested
        set breed prisoners
          set color magenta
          set g-avoided-house-day    g-avoided-house-day + 1
          set g-avoided-thefts-day   g-avoided-thefts-day + 1
          set g-avoided-thefts-month g-avoided-thefts-month + 1
          set prison-sentence 48 + random max-prison-sentence
          move-to one-of prisons
        ]
       if tmp-prob-stole-house > 0.7 [                                         ; if successful. Most of time attempt to stole will enter here
        set wealth wealth + theft-profit
        ask house tmp-house-chosen [
          set times-stolen times-stolen + 1
          set g-houses-thefts-day   g-houses-thefts-day + 1
          set g-houses-thefts-month g-houses-thefts-month + 1
          set color cyan ]
      ]
      ]
  ]
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Person Thefts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make decision in three steps: 1.) Chose a person; 2.) Evaluate circunstance; 3.) Try to stole
;; Person Theft is a function of = f[ Social Risk, Cops around,  victim visibility, ...]
;; If a thief has stolen a house right before, he / she won't stole a person right after.
to try-stole-person
  ask thieves [
    set thieve-time-inactive thieve-time-inactive + 1     ; time-inactive is 36hour at minimum. If time is higher than 36+Unif(240)
    if  thieve-time-inactive < time-inactive  [ stop ]    ; he/she became active and variable is reset to zero!
    ;1. Chooses a person
    set will-try-steal? false
    let tmp-show-wealth false
    let tmp-person-chosen ""
    let tmp-sex ""
    let tmp-marital ""
    let n-person count turtles with [ shape = "person" and age-years > 15 ] in-radius stole-radius
    ifelse n-person > 0 [
      ask one-of turtles with [ shape = "person" and age-years > 15  and breed != "cops" ] [
        set tmp-person-chosen who
        set tmp-show-wealth show-wealth?
        set tmp-sex sex
        set tmp-marital marital
      ]
    ]
    [ stop ]
    ;2. The thieve evaluate the circunstances and make decision: evaluate police around and other factors
;    let tmp-cops-distance min-one-of cops in-radius cops-radius [ distance myself ]
;    if (tmp-cops-distance = nobody) [ set tmp-cops-distance 0 ]
;    user-message (word "Distance: " tmp-cops-distance)

    let tmp-cops-distance 99
    if any? cops in-radius cops-radius [
       set tmp-cops-distance distance (min-one-of cops in-radius cops-radius [distance myself])
    ]
    let tmp-prob-cops 1 / (1 + exp( -(tmp-cops-distance - 5) / 1) )       ; see calibration in ModCrime2021-01.R (increasing function)
    let tmp-prob-marital 0
    let tmp-prob-sex 0
    ifelse marital = 0 [set tmp-prob-marital 0] [set tmp-prob-marital -0.007] ; calibrated according to the econometric model of attempted theft
    ifelse sex = 0     [set tmp-prob-sex 0]     [set tmp-prob-sex 0.0770]     ; calibrated according to the econometric model of attempted theft
    let tmp-prob-visibility 0
    ifelse tmp-show-wealth = true
      [ set tmp-prob-visibility 0.50 + random-float 0.5 ]          ;??????
      [ set tmp-prob-visibility 0.01 + random-float 0.5 ]          ;??????
    let tmp-prob-to-stole-person1 (risk-propensity + tmp-prob-cops + tmp-prob-visibility ) / 3 + tmp-prob-sex + tmp-prob-marital       ; 0 <= all probs <= Average with equal weight
;   user-message (word "prob-to-stole-person: " tmp-prob-to-stole-person " = " risk-propensity " : " tmp-prob-cops " : " tmp-prob-visibility )

    if tmp-prob-to-stole-person1 > 0.75  [
      set will-try-steal? true
      set thieve-time-inactive 0
      set g-persons-attempt-day   g-persons-attempt-day + 1
      set g-persons-attempt-month g-persons-attempt-month + 1
    ]

    ;3. Stole in action, evaluate the result: a.) successfull, b.) killed in action, c.) arrested
    if will-try-steal? [
      let tmp-prob-time 0.8 / ( 1 + exp( -(time-in-crime - 20) / 7) ) ; success is about 80 to 95% of the cases
      let tmp-prob-to-stole-person2 (tmp-prob-time + tmp-prob-cops) / 2    ; success is about 80 to 95% of the cases
     ;user-message (word "prob-to-stole-person2: " tmp-prob-to-stole-person2 " = " tmp-prob-time " : " tmp-prob-cops )

      if tmp-prob-to-stole-person2 <= 0.3  [                                     ; if not successful with very low prob, then die
       set breed deads
          set color brown
          set g-avoided-person-day    g-avoided-person-day + 1
          set g-avoided-thefts-day   g-avoided-thefts-day + 1
          set g-avoided-thefts-month g-avoided-thefts-month + 1
          set viol-deaths viol-deaths + 1
      ]
      if tmp-prob-to-stole-person2 > 0.3 and tmp-prob-to-stole-person2 <= 0.6 [        ; if not successful with not so low prob, then arrested
        set breed prisoners
          set color magenta
          set g-avoided-person-day    g-avoided-person-day + 1
          set g-avoided-thefts-day   g-avoided-thefts-day + 1
          set g-avoided-thefts-month g-avoided-thefts-month + 1
          set prison-sentence 48 + random max-prison-sentence
          move-to one-of prisons
        ]
       if tmp-prob-to-stole-person2 > 0.6 [                                         ; if successful. Most of time attempt to stole will enter here
       set wealth wealth + theft-profit
        set n-persons-thefts n-persons-thefts + 1
        set g-persons-thefts-day   g-persons-thefts-day + 1
        set g-persons-thefts-month g-persons-thefts-month + 1
        ask turtle tmp-person-chosen [
         set times-stolen times-stolen + 1
         set color cyan ]
      ]
      ]
  ]

end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPS-EFFICIENCY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updated once a day at the end of a day
to update-cops-efficiency-day
  if g-houses-thefts-day  + g-persons-thefts-day != 0 [
    set cops-efficiency-day (g-avoided-thefts-day / (g-houses-thefts-day + g-persons-thefts-day) )
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updating Frustation level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Update once a day
to update-frustration
  ask turtles with [ shape = "person" and breed != cops and breed != babies ] [
    let richer-than-me count turtles with [ shape = "person" and show-wealth? = true and wealth > [wealth] of myself] in-radius frustration-radius
    let num-neighbor count turtles with [ shape = "person" ] in-radius frustration-radius
    set frustration-level (richer-than-me / num-neighbor)
  ]
  set g-frustration-av mean [ frustration-level ] of turtles with [ shape = "person" and breed != cops and breed != babies ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updating Risk propensity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Update once a day
;; Risk-propensity - Many functions (age, cops-effic, time in prision, rate-punishment,...) ;;;;
;; a.) age-days
;; b.) cops-efficiency
;; c.) prison-sentence
;; d.) punishment-rate (social experience)
;; e.) caught-rate
;; e.) wealth
to update-risk-propensity
  let average-wealth " "
  ask thieves [
    let risk-by-age              3 / ( (1 + exp((25 - age-years) / 8)) + exp(-(25 - age-years) / 8) )       ;;; quanto maior a idade (até os 25 anos) maior a propensao, depois disso (>26 anos), menor
    let risk-by-cops-efficiency  1 / (0.5 + exp(-(0.8 - cops-efficiency-day) / 1) )                         ;;; quanto maior a eficiencia policial, menor a propensao ao risco
    let risk-by-prison           1 / ( 1 + exp(-(60 - prison-sentence) / 10) )                              ;;; quanto maior o tempo de sentença, menor a propensao ao risco
  ; let risk-by-punishment       1 / ( 1 + exp(-(50 - g-punishment-rate) / 10) )                            ;;; quanto maior a taxa de punicao média, menor a propensao ao risco
    let risk-by-wealth           1 / (0.1 + exp( (my-wealth) / 20) )                                  ;;; quanto maior a riqueza dele, menor a propensão ao risco, porque mais ele tem pra perder
    set risk-propensity  (risk-by-age + risk-by-cops-efficiency + risk-by-prison + risk-by-wealth) / 4      ;;  determinants such us: age, cops eficiency, sentence in prision, rate of punishment (Basilio)
  ]
  set g-risk-propensity-av mean [ risk-propensity ] of thieves
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Updating punishment-rate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Update once a day
to update-punishment-rate
  if count prisoners > 0 [
     set g-punishment-rate (sum [prison-sentence] of prisoners) / ( count prisoners )
  ]
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BECAME-A-THIEVE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Became a thieve should be function of = f[Frustration, Age, Educ, Job, ...) - Basilio
;; Make the decision evaluating the circunstances above
;; Two results can happen: to become or not a thieve
to became-a-thieve
  ask turtles with [ shape = "person" and breed != "cops" and age-years > 15 ] [
    ;; Exit crime world: if he/she is a thieve tries to leave the crime world
    ;; ------------------------------------------------------------------------------
    ifelse breed = thieves [
      let risk-by-age-inverse         1 - 3 / ( ( 1 + exp((25 - age-years) / 8)) + exp(-(25 - age-years) / 8) )  ;; age inverse
      let risk-by-education-inverse   1 - 1 / ( 1 + exp((10 - education-level) / 2))     ; ifelse education-level < nível educacional exigido pelo mercado [0.5 + random-float 0.5] [0.1 + random-float 0.3]     ;;; inserir fórmula
      let frustration-inverse 1 - frustration-level
      let risk-by-time        1 / ( 1 + exp((90 - time-in-crime) / 30))
      let prob-leave-crime (frustration-inverse + risk-by-age-inverse + risk-by-education-inverse + risk-by-time) / 4
       if prob-leave-crime > 0.9 [
;      if prob-leave-crime > 1 - random-float 0.2 [
;       user-message (word "prob-leave-crime: " prob-leave-crime " |frust: " frustration-inverse " risk-by-age: " risk-by-age " risk-by-educ: " risk-by-education " risk-by-time: " risk-by-time)
        set breed workers
        set color green
        ;set breed unemployed_
        ;set color orange
      ]
    ]
    [ ;; Enter crime world: if he/she is not a thieve tries to become one
      ;; ------------------------------------------------------------------------------
      let risk-by-age        3 / ( ( 1 + exp((25 - age-years) / 8)) + exp(-(25 - age-years) / 8) )
      let risk-by-education  1 / ( 1 + exp((10 - education-level) / 2))     ; ifelse education-level < nível educacional exigido pelo mercado [0.5 + random-float 0.5] [0.1 + random-float 0.3]     ;;; inserir fórmula
      let risk-by-employment 0
      ifelse breed = "unemployed_"
        [ set risk-by-employment random-float  0.20]
        [ set risk-by-employment random-float -0.20]
      let prob-became (1 + risk-by-employment) * ( (frustration-level + risk-by-age + risk-by-education) / 3 )
;     user-message (word "prob-became: frust: " frustration-level " risk-by-age: " risk-by-age " risk-by-educ: " risk-by-education)
      if prob-became > 0.65 [
        set breed thieves
        set color yellow
;       setxy random-xcor random-ycor
        set caught? false                             ;; inicialmente, todos os infratores recebem a sinalização de que não foram pegos pelos policiais.
        set will-try-steal? false                     ;; inicialmente, todos os infratores recebem a sinalização de que não vão tentar roubar.
        set prison-sentence 0
        set thieve-time-inactive time-inactive
        set time-in-crime 1
        set risk-propensity 0.2 + random-float 0.3
      ]
    ]
  ]
end

to update-thieves
  ask thieves [ set time-in-crime time-in-crime + 1 ]
end

to update-prisoners
ask prisoners [
  set prison-time prison-time + 1             ;; time-prison in days
  let tmp-my-home my-home
    if prison-time >= prison-sentence [
      set prison-sentence 0
      set prison-time 0
      set time-in-crime 0                     ;; Could this be reinitialized?
      ; De acordo com o IPEA, no estudo mais recente realizado sobre reincidência criminal no Brasil (2015), a taxa no país era de 24,4% - o que representa um em cada quatro condenados,
      ; Paraná foi um dos estados contemplados na amostragem (foram analisados 249 processos, de oito comarcas diferentes). disponível em: https://www.cnj.jus.br/wp-content/uploads/2011/02/716becd8421643340f61dfa8677e1538.pdf
      ifelse random-float 1 > 0.42            ;; Conforme Shikida(2020)  58% is reincident
         [ set breed thieves ]                ;; why not remain a thieve (Basilio)
         [ ifelse random-float 1 < 0.10       ;; assumed 0.10 ?????
             [ set breed workers
               set my-firm one-of firms ]
             [ set breed unemployed_ ]
         ]
      move-to my-home
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GINI Index
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to update-gini-lorenz
  let num-people count turtles with [ shape = "person" ]
  let sorted-wealths sort [ wealth ] of turtles with [ shape = "person" ]
  let total-wealth sum sorted-wealths
  let wealth-sum-so-far 0
  let index-g 0
  set gini-index-reserve 0
  set lorenz-points [ ]

;; now actually plot the Lorenz curve -- along the way, we also calculate the Gini index.
;; (see the Info tab for a description of the curve and measure)
  repeat num-people [
    set wealth-sum-so-far ( wealth-sum-so-far + item index-g sorted-wealths )
    set lorenz-points lput ( ( wealth-sum-so-far / total-wealth ) * 100 ) lorenz-points
    set index-g ( index-g + 1 )
    set gini-index-reserve gini-index-reserve + ( index-g / num-people ) - ( wealth-sum-so-far / total-wealth )
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  DEFININDO ESTATÍSTICAS DE EMPREGO E CRESCIMENTO ECONÔMICO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; na verdade, deveria ser 8760, pois, de acordo com Okun, se a taxa de crescimento do PIB
;; durante um ano for de 2%, no final desse ano a taxa de desemprego cairá 1 ponto percentual
to okun-update
  if turn-growth? = true and hour = 0 and day = 1 [
    ask firms [set available-jobs available-jobs * (1 + 0.86 * (economic-growth / 12) )]
  ]
end

;to update-jobs
;  ask firms [                                ;; comandos utilizados para atualizar as vagas de emprego das firmas. Após determinado período de tempo, caso
;    if day = 1 [
;      set initial-jobs count workers-here    ;; ocorra crescimento econômico, uma quantidade aleatória de vagas de emprego serão geradas
;      set jobs initial-jobs
;      set label jobs                         ;; mostrar quantos trabalhadores estão empregados na firma em questão
;    ]
;  ]
;  if growth? = true [
;    ask one-of firms [
;      set jobs jobs + random 20
;      set label jobs
;      set available-jobs 0.5 * economic-growth] ]
;end

;; first compute vacancy and number of unemployed at disposal to firm
to distribute-jobs2
  let n-firms count firms
  let n-unemployeds count unemployed_ with [education-level >= required-education ]
  set n-unemployeds int( n-unemployeds / 2 )                ;; only half of unemployed will look for a job during a match
  let n-workers-by-firm int(n-unemployeds / n-firms)
  if n-workers-by-firm > 0 [
    let i 1
    while [i <= n-firms][
      let n-vacancy 0
      let actual-firm one-of firms
      ask actual-firm [
        set n-vacancy (available-jobs - current-jobs)
        let n-workers-to-hire 0
        ifelse (n-vacancy > n-workers-by-firm )
          [ set n-workers-to-hire n-workers-by-firm ]
          [ set n-workers-to-hire n-vacancy]
        if n-workers-to-hire > 0 [
          ask n-of n-workers-to-hire unemployed_ [
            set breed workers
            set color green
            set my-firm actual-firm
          ]
          set current-jobs current-jobs + n-workers-to-hire
        ]
      ]
      set i i + 1
    ]
  ]
end

to distribute-jobs
  ask firms [
    let current-firm who
    if available-jobs > current-jobs [
      ask unemployed_ with [ education-level >= required-education ] [
        set breed workers
        set my-firm one-of current-firm
        ask firm my-firm [ set current-jobs current-jobs + 1 ]
      ]
    ]
  ]
end

; ----------------------------------------------------------------
; Commands
; ----------------------------------------------------------------
; count turtles with [ shape = "house-patch" ]
; show sum [current-jobs] of firms
; repeat 10 [ show random 100 ]
; ask peoples [show (list hired-hours hourly-wage income) ]
; user-message (word "My links-on-the bus: " infected-passengers)
; ask thieves [show (list income wealth relative-wealth)]
