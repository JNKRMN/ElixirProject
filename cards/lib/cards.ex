defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of Cards
  """

  @doc """
    Creates a list of strings, representing a traditional deck of cards, using a nested array comprehension

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Jack of Spades", "Queen of Spades", "King of Spades",
      "Joker of Spades", "Ace of Clubs", "Jack of Clubs", "Queen of Clubs",
      "King of Clubs", "Joker of Clubs", "Ace of Hearts", "Jack of Hearts",
      "Queen of Hearts", "King of Hearts", "Joker of Hearts", "Ace of Diamonds",
      "Jack of Diamonds", "Queen of Diamonds", "King of Diamonds",
      "Joker of Diamonds"]

  """
  def create_deck do 
    values = ["Ace", "Jack", "Queen", "King", "Joker" ]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  
  @doc """
    Takes a list of strings and shuffles them 

  """
  
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Contains checks if a card is in the deck 

  ## Examples 

      iex> Cards.create_deck
      iex> deck = Cards.create_deck  
      iex> Cards.contains?(deck, "Ace of Diamonds")
      true
      iex> Cards.contains?(deck, "Nine")            
      false
      
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """ 
    Divides a deck into a hand and the remainder fo the deck. 
    The `hand_size` argument indicates how many cards should 
    be in the hand.

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Save, converts to erlang binary to save to file system
 
  ## Examples

      iex> Cards.create_deck
      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 5)
      {["Ace of Spades", "Jack of Spades", "Queen of Spades", "King of Spades",
      "Joker of Spades"],
      ["Ace of Clubs", "Jack of Clubs", "Queen of Clubs", "King of Clubs",
      "Joker of Clubs", "Ace of Hearts", "Jack of Hearts", "Queen of Hearts",
      "King of Hearts", "Joker of Hearts", "Ace of Diamonds", "Jack of Diamonds",
      "Queen of Diamonds", "King of Diamonds", "Joker of Diamonds"]}

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do 
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "The file your looking for does not exist"
    end
  end
  
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end