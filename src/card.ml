type suit = Spade | Club | Heart | Diamond

type value =
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Ten
  | J
  | Q
  | K
  | A

type card = { suit : suit; value : value }

exception BadNum of int

let string_of_suit (suit : suit) : string =
  match suit with
  | Spade -> "Spade"
  | Club -> "Club"
  | Heart -> "Heart"
  | Diamond -> "Diamond"

let string_of_value (value : value) : string =
  match value with
  | Two -> "Two"
  | Three -> "Three"
  | Four -> "Four"
  | Five -> "Five"
  | Six -> "Six"
  | Seven -> "Seven"
  | Eight -> "Eight"
  | Nine -> "Nine"
  | Ten -> "Ten"
  | J -> "J"
  | Q -> "Q"
  | K -> "K"
  | A -> "A"

let string_of_card (card : card) : string =
  "{ suit = " ^ string_of_suit card.suit ^ "; value = "
  ^ string_of_value card.value ^ " }"

let rec string_of_card_lst_helper (lst : card list) : string =
  match lst with
  | h :: t -> string_of_card h ^ "; \n" ^ string_of_card_lst_helper t
  | [] -> ""

let string_of_card_lst (lst : card list) : string =
  "[ " ^ string_of_card_lst_helper lst ^ " ]"

let suit_of_num (num : int) =
  match num with
  | 0 -> Spade
  | 1 -> Club
  | 2 -> Heart
  | 3 -> Diamond
  | _ -> raise (BadNum num)

let value_of_num (num : int) =
  match num with
  | 0 -> Two
  | 1 -> Three
  | 2 -> Four
  | 3 -> Five
  | 4 -> Six
  | 5 -> Seven
  | 6 -> Eight
  | 7 -> Nine
  | 8 -> Ten
  | 9 -> J
  | 10 -> Q
  | 11 -> K
  | 12 -> A
  | _ -> raise (BadNum num)

let rec make_deck (acc : card list) (iter : int * int) : card list =
  match iter with
  | suit_iter, value_iter ->
      let card =
        { suit = suit_of_num suit_iter; value = value_of_num value_iter }
      in
      if suit_iter = 3 && value_iter = 12 then acc @ [ card ]
      else if value_iter = 12 then make_deck (acc @ [ card ]) (suit_iter + 1, 0)
      else make_deck (acc @ [ card ]) (suit_iter, value_iter + 1)

let shuffle d =
  let nd = List.map (fun c -> (Random.bits (), c)) d in
  let sond = List.sort compare nd in
  List.map snd sond
