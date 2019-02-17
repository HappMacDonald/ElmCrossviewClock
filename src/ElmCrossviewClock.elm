
import Browser
import Html exposing (Html)
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Task
import Time



-- Constants


fontSize : Int
fontSize =
  24


red : Element.Color
red =
  Element.rgb 1 0 0


green : Element.Color
green =
  Element.rgb 0 1 0


white : Element.Color
white =
  Element.rgb 1 1 1


slot : Element.Color -> Int -> String -> Element msg
slot color width char =
    Element.el
      [ Element.width ( Element.px width ) 
      , Font.alignLeft
      , Font.color white
      ]
      ( Element.text char )


narrowSlot : String -> Element msg
narrowSlot char =
    slot red (fontSize*3//7) char


normalSlot : String -> Element msg
normalSlot char =
    slot white (fontSize*4//7) char


wideSlot : String -> Element msg
wideSlot char =
    slot green (fontSize*5//7) char


gutterSlot : Element msg
gutterSlot =
    Element.el
      [ Element.width ( Element.px (fontSize * 3))]
      Element.none


testSlot : List Position -> Int -> Int -> String -> Element msg
testSlot positions mainRow mainColumn character =
  if List.any
    (\{row,start} ->
      row == mainRow && start == mainColumn
    )
    positions
  then narrowSlot character
  else
    if List.any
      (\{row,start,length} ->
        row == mainRow && (start+length-1) == mainColumn
      )
      positions
    then wideSlot character
    else normalSlot character




type Word
  = NumberMinuteWord Int
  | NumberHourWord Int
  | Twenty
  | Half
  | Its
  | Noon
  | Midnight
  | AM
  | PM
  | Past
  | Til


type alias Position =
  { row : Int
  , start : Int
  , length : Int
  }


textBlock : List String
textBlock =
  [ "IT'STWENTYHALFTHREEONETWO"
  , "EIGHTFOURSEVENFIVESIXNINE"
  , "TENQELEVENTWELVELTHIRTEEN"
  , "FOURTEENA QUARTERASIXTEEN"
  , "SEVENTEENEIGHTEENNINETEEN"
  , "PASTATILHONETWO THREEFOUR"
  , "FIVE SIXHSEVENTEIGHTRNINE"
  , "TENELEVENNOONMIDNIGHTAMPM"
  ]


wordPositions : Word -> Position
wordPositions word =
  case word of
    Its ->
      { row = 0
      , start = 0
      , length = 4
      }
          
    Twenty -> 
      { row = 0
      , start = 4
      , length = 56
      }
          
    Half ->
      { row = 0
      , start = 10
      , length = 4
      }

    NumberMinuteWord 1 ->
      { row = 0
      , start = 19
      , length = 3
      }
          
    NumberMinuteWord 2 ->
      { row = 0
      , start = 22
      , length = 3
      }
          
    NumberMinuteWord 3 ->
      { row = 0
      , start = 14
      , length = 5
      }
          
    NumberMinuteWord 4 ->
      { row = 1
      , start = 5
      , length = 4
      }
          
    NumberMinuteWord 5 ->
      { row = 1
      , start = 14
      , length = 4
      }
          
    NumberMinuteWord 6 ->
      { row = 1
      , start = 18
      , length = 3
      }
          
    NumberMinuteWord 7 ->
      { row = 1
      , start = 9
      , length = 5
      }
          
    NumberMinuteWord 8 ->
      { row = 1
      , start = 0
      , length = 5
      }
          
    NumberMinuteWord 9 ->
      { row = 1
      , start = 21
      , length = 4
      }
          
    NumberMinuteWord 10 ->
      { row = 2
      , start = 0
      , length = 3
      }
          
    NumberMinuteWord 11 ->
      { row = 2
      , start = 4
      , length = 6
      }
          
    NumberMinuteWord 12 ->
      { row = 2
      , start = 10
      , length = 6
      }
          
    NumberMinuteWord 13 ->
      { row = 2
      , start = 17
      , length = 8
      }

    NumberMinuteWord 14 ->
      { row = 3
      , start = 0
      , length = 8
      }
          
    NumberMinuteWord 15 ->
      { row = 3
      , start = 8
      , length = 9
      }
          
    NumberMinuteWord 16 ->
      { row = 3
      , start = 18
      , length = 7
      }
          
    NumberMinuteWord 17 ->
      { row = 4
      , start = 0
      , length = 9
      }
          
    NumberMinuteWord 18 ->
      { row = 4
      , start = 9
      , length = 8
      }
          
    NumberMinuteWord 19 ->
      { row = 4
      , start = 17
      , length = 8
      }
          
    NumberMinuteWord _ -> -- Q
      { row = 3
      , start = 3
      , length = 1
      }
          
    Past ->
      { row = 5
      , start = 0
      , length = 4
      }

    Til ->
      { row = 5
      , start = 5
      , length = 3
      }

    NumberHourWord 1 -> 
      { row = 5
      , start = 9
      , length = 3
      }

    NumberHourWord 2 -> 
      { row = 5
      , start = 12
      , length = 3
      }

    NumberHourWord 3 -> 
      { row = 5
      , start = 16
      , length = 5
      }

    NumberHourWord 4 -> 
      { row = 5
      , start = 21
      , length = 4
      }

    NumberHourWord 5 -> 
      { row = 6
      , start = 0
      , length = 4
      }

    NumberHourWord 6 -> 
      { row = 6
      , start = 5
      , length = 3
      }

    NumberHourWord 7 -> 
      { row = 6
      , start = 9
      , length = 5
      }

    NumberHourWord 8 -> 
      { row = 6
      , start = 15
      , length = 8
      }

    NumberHourWord 9 -> 
      { row = 6
      , start = 21
      , length = 4
      }

    NumberHourWord 10 -> 
      { row = 7
      , start = 0
      , length = 3
      }

    NumberHourWord 11 -> 
      { row = 7
      , start = 3
      , length = 6
      }

    NumberHourWord _ -> -- Q
      { row = 3
      , start = 3
      , length = 1
      }
          
    Noon ->
      { row = 7
      , start = 9
      , length = 4
      }

    Midnight ->
      { row = 7
      , start = 13
      , length = 8
      }

    AM ->
      { row = 7
      , start = 21
      , length = 2
      }

    PM ->
      { row = 7
      , start = 23
      , length = 2
      }

{-

It'sTwentyHalfOneTwoThree
FourFiveSixSevenEightNine
TenQElevenTwelveLThirteen
FourteenA QuarterASixteen
SeventeenEighteenNineteen
PastATilHOneTwo ThreeFour
Five SixHSevenTEightRNine
TenElevenNoonMidnightAMPM

-}


-- Helpers

modNonZero : Int -> Int -> Int -> Int
modNonZero begin length value =
  ( modBy length ( value - begin ) ) + begin

-- presume number input is strictly 0 <= number <= 30
numberToWords : (Int -> Word) -> Int -> List Word
numberToWords tag number =
  if number == 0
  then []
  else
    if number < 20
    then [tag number]
    else
      if number == 20
      then [Twenty]
      else
        if number == 30
        then [Half]
        else -- presume 20 < number < 30
          [ tag 20, tag ( number-20 ) ]


nowToWords : Model -> List Word
nowToWords ( {time,zone} as model ) =
  let
    hour24 =
      Time.toHour zone time

    ampm =
      if hour24 < 12
      then AM
      else PM

    hour12 =
      modBy 12 hour24

    minute =
      Time.toMinute zone time

    signedAmountPastTil =
      modNonZero -29 60 minute

    minuteWords =
      if signedAmountPastTil < 0
      then
        ( signedAmountPastTil
        |>negate
        |>numberToWords NumberMinuteWord
        )
        ++[Til]
      else
        ( numberToWords NumberMinuteWord signedAmountPastTil ) ++ [Past]

    hourNear12 =
      if signedAmountPastTil < 0
      then modBy 12 ( hour12 + 1 )
      else hour12

    hourNearWord =
      if hourNear12 > 0
      then [ NumberHourWord hourNear12, ampm ]
      else
        case ampm of
          AM ->
            [ Midnight ]

          _ -> -- assume PM 🙄
            [ Noon ]

  in
    [Its] ++ minuteWords ++ hourNearWord

-- MAIN


main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL


type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0)
  , Task.perform AdjustTimeZone Time.here
  )



-- UPDATE


type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Tick



-- VIEW

view : Model -> Html Msg
view model =
  let
    words =
      nowToWords model

    positions =
      words
      |>List.map
          wordPositions

  in
    Element.layout
      [ Element.width Element.fill
      , Element.height Element.fill
      , Element.centerX
      , Element.centerY
      , Font.center
      , Background.color (Element.rgb 0 0 0)
      , Font.family [ Font.monospace ]
      , Font.size fontSize
      , Font.color (Element.rgb 1 1 1)
      ]
      ( Element.column
        [ Element.width Element.fill
        , Element.centerX
        , Element.centerY
        ]
        ( textBlock
        |>List.indexedMap
            (\row line ->
                List.concat
                [ line
                  |>String.split ""
                  |>List.indexedMap ( testSlot positions row )
                , [gutterSlot]
                , line
                  |>String.split ""
                  |>List.map normalSlot
                ]                
                |>Element.row
                  [ Element.centerX
                  , Element.centerY
                  ]
            )
        )
      )
